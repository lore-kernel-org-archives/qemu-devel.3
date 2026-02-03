Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0808E87859
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMdd-0006HQ-LA; Tue, 03 Feb 2026 15:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1vnMdc-0006HC-Bx
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:04:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1vnMda-0006fO-74
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:04:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613IuY1j4088173; Tue, 3 Feb 2026 20:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=u4lsBS4sXyUEu62xsE
 3ukBQxWelo7mOF3eO+59zosl4=; b=khY+US7rpGtknqC4Y9fem3dtI5zgv42JHO
 5FAuqlaFlGDLLD5gwwAAkYkA9MeyReJmMa0TjdgzRhyeE9etY3mVuo4rEeY7bflp
 NmrC7R6K/+ybGnK0s58EhTEotapURxXr7BuAdgdMWWOzVlgrvBXk1uw23msQV6mb
 44Sbv5o0sYeFBvdVLlIGSIv6l9b82L5hngjj52nf72IvnjN6kqI2cUAvj9qaL9dN
 zGxWH5dJvN0BZFlyAibXMLr42JYpx0LKj1MSF9Vhpw60oaBc2Rx9Lo7QkQZFf624
 eZd4KJd7r4zf6sSHU1Zf8lIkXAvx2SDNmWDIw/HexmPPrXCzXAlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb0p29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Feb 2026 20:04:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 613Iq3Ag002262; Tue, 3 Feb 2026 20:04:30 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4c186mv392-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Feb 2026 20:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAX2bVxoW+gmNzBzd1TiecB9vo4rsnaLV/y6HLKAx4rNAJ7b7XnR1khueg82mlVsAPjbZ6V/n+HbkZCKcgpYiZZbZ2FMUuo8JLX4KD3QWp/4jrfY9vnX+VvvfJmIPaPTPf6g1Nt8ebZ0Ql+PVrSm7UfbBC25W0h8bOkbVCXHfgTlajpZ56bfXAORZl6go09mEWqiiu/5kRI82MUxkLQ9JllfDfvlFtIqYHf7iyrRIrHSggHCHt86iUWl9JgDMLkMFY80maoJjzKTI9GGGjFJCuw4k2Dbn4znkHo4+uCJuVAPwrDMErU6rI1GiPyHNqmLtZMKa/urvguVRRuQlbfHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4lsBS4sXyUEu62xsE3ukBQxWelo7mOF3eO+59zosl4=;
 b=Ai5CXzZko6JCpXoGGLefxPRXisFG3ilmnG6j/qCAjn6WeE5exWKDq4P1CHs5vsINNB/yUUom9MVKdLvEJ65y/GR7qe8mXNNBKb7eQ/W/LdWovLOOgUsOIWlzjc9s4/d9KnZKnh0IC2NlcXX0YN24HZEIQR4j5J3MqTng5Lw43IG31SJJsMMycldtWCKFcHFEfWuL4F/ERagqHsuT0kIg9BG+TjchWRwNu8swRoC06cPQdiAkWMDadBDBidES+Ge90LiWsVS9Tdj8U1uFAyo7nYAMZEhIwisBFGBJhXUC+59pNoQGQ1XCZQPrtbIH1fGItCE2D6/VNl1Ys3GCksqc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4lsBS4sXyUEu62xsE3ukBQxWelo7mOF3eO+59zosl4=;
 b=ahg28tALGRbVXtLHigNdF528bpUhZwEiVri9NunqP24ApCjEv4Rp38KoeJTpGfqp8/nkpYugVWUzktjZwychr8rInfi+LzXDLMnlq7RVgJp7W48a7aqZM9oOA3oaVtzp8U9HAjQIDUAmknCmuNh/aT/mSs91TISYwly3Mf512PY=
Received: from BLAPR10MB5170.namprd10.prod.outlook.com (2603:10b6:208:321::18)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:04:26 +0000
Received: from BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191]) by BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:04:26 +0000
Content-Type: multipart/alternative;
 boundary="------------JQDINt01iYa0b863qkDC90sH"
Message-ID: <58d40cb1-a5fc-4dce-b843-2b08b79c477a@oracle.com>
Date: Tue, 3 Feb 2026 14:04:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
To: "Chaney, Ben" <bchaney@akamai.com>, Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local> <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
 <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
 <aYJJ17xU2iQmk5sQ@x1.local> <111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com>
Content-Language: en-US
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com>
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To BLAPR10MB5170.namprd10.prod.outlook.com
 (2603:10b6:208:321::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5170:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 673969ae-99fb-4b0f-2e3b-08de635f6ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE15TU5xdUhoWVpYNUtKSHhwbW84MHlldnlpZlExbHI3bFFSQzJoYzBqQk9R?=
 =?utf-8?B?a1JxcWthKzZFaUF5T2hHcU9WWDZMMDdHOFhWU0Z2by9aUUlacEhXMWY5c0N1?=
 =?utf-8?B?dWRyYjJiaWI0ZVEvaHhBdGN2RGd1akpWYi9uYVpZV2RqM3Vmb1Y3TDFMd2la?=
 =?utf-8?B?YWJid2tEZUtzcVVSTHIvWEN2d1JyTjliZllxVjk1dVBpRGZUNHBZaktzZk9O?=
 =?utf-8?B?MWJNTzRxTVl4c0tDaDlmMGFFMEhUTm4vZnhMUHZuK0tzbkZCSFkzKytrRkNz?=
 =?utf-8?B?K0NnbGMrcm8rSEh6T3J6R2xkQ1d4cXFhM0l1Y1FzeG8rMGM0WmhxbFZNVFFK?=
 =?utf-8?B?ZisvdEVUeEd5Yy9jRTVwQVFEYWQ0NElBWnljb1htSmE0L2RDZlMycjE0SW93?=
 =?utf-8?B?UE9JL3Z2VDhEamplYllwdHN1TGtWOGRvdlArTmJKcUdQbHZtQjB2RlMra1FE?=
 =?utf-8?B?TDljTXhQaDlPY3Y1SWc2R2o2WVpmMjlOQmp0SDRGWW05UStsTHN5WEVBOE91?=
 =?utf-8?B?Ynk3aDlCZEwwVXBrb1cwUnFSZTFhZ0RVblhiV2QwSFpTOXBRVGczNEJmOWtj?=
 =?utf-8?B?RSt0TVVYdjVsOTRBZ0hqNHhWV21yS2pWQlpEcTU5dllKbWdGTFFLRVozeU9C?=
 =?utf-8?B?dGZYSDRlUzBwa0ZETVR2NWpBbjkrUDJtMkZZVWhnWU1FbmFEZzIxcmhKbXVM?=
 =?utf-8?B?REhEWHVOU3duWXh4QnZnOTRtaVRmSlRlNXR6WWNSdHhhRVRmZ0QxODMrUEFG?=
 =?utf-8?B?R0l4RkVVVTZTL1pwYVpPNmx4VHdtN054UURkSlBpUmR6TGFXUEFwdXc2eklB?=
 =?utf-8?B?WENSRytxeEpYc2ZkVWQ4VVJzUU4vVk0rbGhrODA5bTY4OTdYdUtuSjk0ZGlq?=
 =?utf-8?B?bGx5S3kzUUNVaVk1WFZnVHRkZzZrZnRJQnpkV2MySWF5SWExS1c5eklBWm9C?=
 =?utf-8?B?dnZEQ0NNb2d0WUNjdktSYVB2eXZTU0RoNWtjTlJtQndieFhxbFQyc0xvUVhu?=
 =?utf-8?B?SUJKSHhMcTY3WVlmWlVaeHJoU3I3WjgwNTNqT1ZyS2kwN2MrclJIRVBaUXhi?=
 =?utf-8?B?M1R4ZHRjQ1V4dzlaSCtmUVM3c1padk1nRERSYTVWd0NTVzNQNFdvOUF3eG9l?=
 =?utf-8?B?WVZjUWNoTzdaNjgrSUFXeStCWUlMWllFVy9VNXh5L2QybytkdGhMb3VKcFRo?=
 =?utf-8?B?ZzNhYnNzR3lGTHgrMm1iVi83NHFHOCtTaFppRDVHbTRtTFVNV2FpSnJkb0Iz?=
 =?utf-8?B?VVpVYThJLzA0dGhZaGg3LzB2ektaV0FwRWVtQTVnVGVkUmd3akxuZHRHdk1m?=
 =?utf-8?B?dWN1VllUcC9LUFN4dUpkS1JHOUZxeXhwb2RmSmd2aWFNYkg2Y1BnNU94NWxs?=
 =?utf-8?B?aUhtT0doQjQ0MlNFZCszQzd1S0t6VWpnKzNOUzJkNDBlOGkrZnVRSzQwZmEv?=
 =?utf-8?B?dEIvWE1kdVljZVNnbW4zbkg1MHpJVHRRY2xQRGJZQ2RDVTd0WUFNZEQxUzg2?=
 =?utf-8?B?eFgrRThpTkI2c1ByODNUNGRMRURDUjVUYTV2WnVxNUdyeTdmMWRYYWZCeGdD?=
 =?utf-8?B?T0RseHowcDUzR2hUdlRYRTNVZ1g1Z0ZpR3NWYVY1L3dXM1B2WU1GVDRRcUg5?=
 =?utf-8?B?SGhyUERDRFdQNVloZitpU3JqK2NyenIySWp1cWxFWXpUY2FTbXdlYklvVW55?=
 =?utf-8?B?cW9PUm1yL1FMbDdsY1ZvU3Z1UjMrcUJYVUJjMkpIV01xQkVSR2VZVDh1b3RB?=
 =?utf-8?B?TXYxTkY4SDNnQkxPbEd2Sm9zK1NXVmJncEZrVjJjb09UYWUxUDdjaGhBYmox?=
 =?utf-8?B?ekJHMnFrL1RLRmpUeW5RWUNQRXpGcFI3MzRGUXU2MlpJanF5T1lFT2J0SSs4?=
 =?utf-8?B?OEVhbFR6Z0Y5dnNjRGVHK3BXQTBWTlJ3UTVqM2tzZlVndGVuemFRdWo3MFhD?=
 =?utf-8?B?eW9ZVXhFc25yVzRnNkNOMkUzNXBoYkJGdGVHamgyVnM2WUtMMzBoeUt3WGN4?=
 =?utf-8?B?cFJWQlQvNUZpYnM3bk5QK3Y3a2R4ZnNheEZ0N3BscmxFRG93ZHdub3FqVmZZ?=
 =?utf-8?B?NU9RWDRhVkttUSszVVNreC9XbEgyNmt4Ky85Z0FFSjVncE9iZC9jSUZuZlhu?=
 =?utf-8?Q?Osao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5170.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTJORHhQMm91V1FMY0YxSStuVHV1YnRlRDdmaGQ3cEVDNmorUElPeTk5TG9N?=
 =?utf-8?B?emV6L3R3Zm1CUFYwc3lqdVFWcjliVWw4VjZsQWxDV28vVUsveGZ0MHZnZmN1?=
 =?utf-8?B?OWdjMjB4d3lMYlJ6ZUZ2dGh4ekN3TUtMZVJIQzZqNXd6L0JNenhwTWtXY09y?=
 =?utf-8?B?UjdlYkNEMGN0RWRBMC9KM3FSa1VRc056QUh2OEx5eGhoVjNWaThicjV2ajla?=
 =?utf-8?B?MFJlRFZDaUF6SWQrQllIUXVJQjFZbW5La0RMN2I0Q1ZDNkRjbEJGUExZUW5Y?=
 =?utf-8?B?TW8vM1JpeElHU2s3MU1tMkJFTjNGTXhCKy9RNExVeUxZUEhTTVFGK3V4S3pP?=
 =?utf-8?B?bGNtaXNmVmRMSVpSdlQrWStwcy82RzN6VldDaHV5R1RDTG5MWDBCNUZKQWZ3?=
 =?utf-8?B?VloxR1RFK2Ztaks1U3lLeHkrVjBTMndYaG92SDF4OVJ0cUJubGVqSXVyMVlM?=
 =?utf-8?B?TWtXY2tHU1c5TGJIYnVCMTZIbEFGWXAydWw5UzVUbzNucjQ1WHAzVDltbW1J?=
 =?utf-8?B?V0l0U3ZxU1luek1DSzFVS2MvQ0VicEVTNW5QZVNKRS9maVM3OTV3ZDhTTjhK?=
 =?utf-8?B?NlR1OUhFbUZCMDQ3RmxqMWp4MTJWejVMdUVlaCtHaUVVazZvNFBZUVNSRW91?=
 =?utf-8?B?ZFE0allWZ0JocGVCeStubmIwWkFuckhhMmZQdi9FTUVzaUROcmRaMTNzcFFL?=
 =?utf-8?B?c0xKaXRIWDhGMFIxaytQUUlkcXFLUFlvVmpPSG5UOWZNMUQxdytlTnJQSlhz?=
 =?utf-8?B?ZXI1SlBEN1pJOWlDSWxpaUR0MXMzNTVBaDN6VDJ4cE5xWkVYQzEyTEs0clhs?=
 =?utf-8?B?YVNvRHViY0k5VWVyZmJQQ1FEbTVSVytCZGFKNXVWSVlPL05aNXcrMGczWkk5?=
 =?utf-8?B?cW9OSWY1ck5DY1AxWFZCejdJMGVzcUd4WFVRbDBRbHd6Nm1wSmtBdk5BOUMr?=
 =?utf-8?B?eSsyUkZseUpNdVI3aEk5dnFoVDUzcXFOUEdjaFNGMGVKS01oSk1Ob2xPRG1P?=
 =?utf-8?B?V0NIZmNBanVDbk85Tjk5R0praC9La01EeEw4VWFSTmFYWW1rYUtuQ09mUHhs?=
 =?utf-8?B?K3dVRitIUGZ2NmJYdTNOU1RLTUppbFdWZmRLQkthcU5DbDhwdnFMNE5BQVBE?=
 =?utf-8?B?aVFPa3o3VHI2SjdiVW9NSXdjZHFaTEx0Um0yTmlvOHZ4S3JDNDRnY3M4WUZa?=
 =?utf-8?B?RnZ1VHFHdVc5aDdnaXltZWlxTXAwbnNhdXRzTFVlenRlTXVYNm5uczV6Tmlx?=
 =?utf-8?B?VCtLZSswVVROMmJhbDc1eC81c28wUWtJQ2FxdWVVVDN1dFV4alRzK0pPVjhH?=
 =?utf-8?B?R3FCT3BmSzVXRVZiSDFaTlptSk9jb2NSQWhoalV1Qlo3SmpWcnViWisyZE9V?=
 =?utf-8?B?bkQ5d041ejFocDl4MnEyL1kxRXRKVmZ4aDAvWG1jNWk3NG1FdVVsWjdzQ2tE?=
 =?utf-8?B?M09lWVVNVmZ5RzI1ZUlzNzMrNGgyTnVWZ0pnR21Lb2t3SU1OMGJVOEZaM2lq?=
 =?utf-8?B?Qnl4dFZ1TW9wL0lRb1hRd3FtNHZPWUpEK3VxRjFrUDRObWJsYitHTElTRDJ4?=
 =?utf-8?B?RHl2WEhUK3hCR3FFeG9WRTdGd3VmYWZFNURTcURUWElJR2NYcnlIcXFIOFRE?=
 =?utf-8?B?ZkdlYXlZdm5JQWNCa1B2WGYrSVRpaXVyUWpSUWVFU3lWOXdSY1R0YVpEQUpl?=
 =?utf-8?B?bVM4R2JuMThmbmd6cytzVWVoaktFTVA5VGk3SCtvTlJKT1FMREd5QVVzNW02?=
 =?utf-8?B?dElaZjFoVnVkVlZTTnZDQjFnUk1ZenJOME1SaDdUQ3Q2c0RWeWtPR0tnNWs1?=
 =?utf-8?B?RXk3YXBOREdZc0xuL2xLN1dRa2VIZFU2V3FsSHZ2QUVzbUdGVTRMMnZKYzQ2?=
 =?utf-8?B?ZGI3a0FwdzNWVTdHZERoN20xaEFod2NuaVJwODBOaDN5eU53VlptcDI4ZkFr?=
 =?utf-8?B?d3JrYXprZVozVysvMU1JK2lSVU9ERFpzb3ZvLy9oUmoxTlRKK3lWcEdCYU40?=
 =?utf-8?B?UHNrTllNbC8yQlo0RWdJcm5lSHJqWU1Zbnp1TjNQQTVXOERmUjRURW9sNVJ6?=
 =?utf-8?B?MmlQS2U0RDhFVm5MbXFQcmJRVlNqWWswTVNFb1c2azExaEFHRzY0Z1hCYkdi?=
 =?utf-8?B?citRaFpnNy8wenlKcWQxQ0J0YzVsUExEWlZOMDlPQWdsSFczLzUvRms3N21k?=
 =?utf-8?B?WjUvZHJqc0pKOHkvSzkwT1Nha3laVjdwZklISEIwMWYyQVNmamJyWDQ3TENL?=
 =?utf-8?B?RjlJdGk4cm9FL2k4cXpLbFprNGdCTHdnK05yLzJsMitkdGZOaXVwRjAwRjhH?=
 =?utf-8?B?dUJaZis2c0RMSnZYM2swUUxQUTI2VnErZmh6WFh5MDlKcGg1bUgwQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oR3Q4gVqHc9SMquZdlO4eb359PAVWWj4h23tTE7hiDoTl+jlSPtY594y4iRHou3uNS6c8eYvoChATen5kyUJK10Sa7j676pW1Ayn65uaWRTNHa5z9DZKk2kbunoSfLdO+8ohL7bysOWdC0lklM+yaNv2lHrFrN1NKW2Q+jX9BKNcu36/Wj49ENo0tXxKtcHbCxg5XdJzstVldBHnk2Y8MZQXqjHHO5Q3BXlSaDhTDp8jkA7LiUHIgSdLOxgfKEzlO1vABVN82pb+iG+jWvcm/SVNQJEjHdJIuo7ze2acELU2C1CDihk+HjY6U0U2Gr/9ny0uvSmM0Oe0quvmib4YfnhdfGoLWcrBoMbzp+ZvAP+BzpaxfDPlJ3QfLu2w5b4HBs/oIHNczV7x5JJXSiYN1GehUq7enzVjMDGUDAMoA0pNYLfhA2sLmqxwsO0vhUNHq1yxjXLKxwgHGamwg/4+psetsGGgNOhpqWnqPWX6I1Aza+yMgAuQMpyGBug8TnTmOfPPRuXt/NTRVL6Ofb8tPSbuxgeYUeQj1KNcBl8YKbinICBWyINibliJuZFuAHT01wfhu6F8QqA65+jz3aJ3grboD8QeLxCCYNJZu3kFpqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673969ae-99fb-4b0f-2e3b-08de635f6ea7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5170.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 20:04:26.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7lu1YKeacqICXOgndqV1/WaqZtjQn6WD4ykVNrrcvqYN7GhuDnl+I8sMNS1ana8KO0ln2JMCYuhivguuUP9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_06,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602030159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE1OSBTYWx0ZWRfXy7vQ9trip6cx
 3awvCawRblcpTpLOC3Ty8vSUxgfZqK0Gj/A1+0oYu60aHKzdqTnXAIvJ4z4LI7ySt1NqkpaET4M
 X185Q2rPBLrRol9X2fISLA09j5CJv5R2Aw/IxzajgjpornL/RShhN7jjh55ZHdbubvs/QCZr8E0
 v3HRtpwecApvPZm/DDsM2O9Lp8KBhtT3HCIKlZVPzeUtnwfAzu0NhPecxcvLf6RW9WNAKmkKYQX
 azllmC6MMG8KTnN/zRqGVBegnm6uFme7pQnX2YVM6RL2OeSeaS4Qfh+FUSIwZI0THHd2aNYtAHi
 2XZQIsEsv8WA/ZdniZxjnRik8dXQms7eJNI1JanRLSAh7skxZzle4udcZ94bmJnu7apTGQSFdSE
 8IeyE+HClNVQIX9/EOmBM0Xr7istlNtrAXjjOodgtiE4d80fe7QmktczmfqL+ErG8Dn9/BMXbsQ
 iwbjmS6O+ZvnJwHeS1mPcsZYQyrv890Q+sKshl4s=
X-Proofpoint-ORIG-GUID: INzpoVSucX5Fk7KkaYGhvHTHYY7nQvV9
X-Proofpoint-GUID: INzpoVSucX5Fk7KkaYGhvHTHYY7nQvV9
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=698254cf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nWzPQIiijJdeqda8gyUA:9
 a=QEXdDO2ut3YA:10 a=X7Ea-ya5AAAA:8 a=eQrCc7mu8bKMpbFZNZQA:9
 a=9KbRgV2-CAouVETM:21 a=_W_S_7VecoQA:10 cc=ntf awl=host:12104
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--------------JQDINt01iYa0b863qkDC90sH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 1:46 PM, Chaney, Ben wrote:
>> Well explained, thank you Vladimir. I wish some day we can move all at
>> least cpr-transfer users to local-migration and deprecate CPR if ever
>> possible. The uncertainty to me is cpr-exec, but I really don't know how
>> much mgmt is adopting cpr-exec.. cpr-reboot also looks pretty special and
>> may not be relevant.
>> The core idea (originated from Steve..) is really about fd sharing, and
>> it's great if we can do it in a cleaner way.
> Thanks for the clarification. If that is the case then probably Vladimir's
> solution is preferable. I sent some comments on the prerequisite
> refactoring patch set. I'll try to review the main set soon.
>
>> My understanding is there're some special mgmt (Oracle's?) that may depend
>> on cpr-exec; I'm not sure how far that went in any downstream deployment.
> That should be able to reuse mgmt channels too (relevant to chardev fd
> sharing, perhaps?) instead of requiring e.g. all monitor ports to reconnect
> to a new QEMU after migration. Said that, I always assumed re-connect is
> fine, and most mgmt supports live migration so the mgmt should have that
> infrastructure there already. Maybe Ben would know better.
>
> I'm missing a lot of context here as I only became more involved in this project
> recently. @Mark Kanda Can you provide any context about Steve's work before
> he retired, or Oracle's usage of these features?

We (Oracle) have an internal VM manager which relies on cpr-exec, and would
like to continue supporting it.

Thanks/regards,
-Mark

--------------JQDINt01iYa0b863qkDC90sH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#f9fcff">
    <div class="moz-cite-prefix">On 2/3/26 1:46 PM, Chaney, Ben wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Well explained, thank you Vladimir. I wish some day we can move all at
least cpr-transfer users to local-migration and deprecate CPR if ever
possible. The uncertainty to me is cpr-exec, but I really don't know how
much mgmt is adopting cpr-exec.. cpr-reboot also looks pretty special and
may not be relevant.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The core idea (originated from Steve..) is really about fd sharing, and
it's great if we can do it in a cleaner way.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for the clarification. If that is the case then probably Vladimir's
solution is preferable. I sent some comments on the prerequisite
refactoring patch set. I'll try to review the main set soon.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">My understanding is there're some special mgmt (Oracle's?) that may depend
on cpr-exec; I'm not sure how far that went in any downstream deployment.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That should be able to reuse mgmt channels too (relevant to chardev fd
sharing, perhaps?) instead of requiring e.g. all monitor ports to reconnect
to a new QEMU after migration. Said that, I always assumed re-connect is
fine, and most mgmt supports live migration so the mgmt should have that
infrastructure there already. Maybe Ben would know better.

I'm missing a lot of context here as I only became more involved in this project
recently. @Mark Kanda Can you provide any context about Steve's work before
he retired, or Oracle's usage of these features?</pre>
    </blockquote>
    <br>
    We (Oracle) have an internal VM manager which relies on cpr-exec,
    and would like to continue supporting it.<br>
    <br>
    Thanks/regards,<br>
    -Mark<br>
    <br>
  </body>
</html>

--------------JQDINt01iYa0b863qkDC90sH--

