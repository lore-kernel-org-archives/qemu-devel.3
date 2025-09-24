Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7578CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1U2g-0003L3-V9; Wed, 24 Sep 2025 14:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1U2W-0003Hb-Sd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:16:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1U2D-00034O-FW
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:16:26 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHtvLD019723;
 Wed, 24 Sep 2025 18:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=c+pckJ/O5Gf5q7XVZrGIYCY66Fv0BViRvYp+3wkewKg=; b=
 hVHPqEy5DprRzRA+FezcN0/KV/qptB5JvP64/LOQB0Ovs7/75SdNT8FZpinw9adD
 scIeHx8Crx/cBFNmKpeFMNhmeaWKRRvcAgfISwY8B81OMVae2TelXy6oL+RxHOIj
 RIfLwwv38B74igNX8G+FPexaaOg2Ck91NUBxXMCgb0ilEPCWziJ+IHD60FR3Nspo
 pOaGXax6yH6q6ueFZtTM8F98a0+rJechVNBQ5fcw68eaLexl1CAF4E/O2BBjJwVf
 LAlrw/S16JfFZ6CfiSQzYySkyEc07xZ9VncLmtWqZPjiYALTEkN5UvCviQCN4B9y
 GryCtpBY2QbVmJfmsTfrIg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdr9aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 18:15:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58OH1WmV014065; Wed, 24 Sep 2025 18:15:47 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a95134ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 18:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSVwQWo0FZ/IibLIjCUBQzOb1UidR1EkzehM127rkgLkVtlEXGtDMASBzgiAiYHKR8tibQZ6NQ+CiMkV/w9CiZHiHBg8Ey3fqLuEbkYC+gl4+EoMnB7F0cozoJVZpyOVHeHPcRcwvAZz4g9W0cRGOv1Kw6cD7Rxn0Kdp6Y+mb26YN8mzmAMCmUYGyRVBJLG8FWeh+sUPr1AEQavJKjvPkw3t52eQ6ZOrZhfVHDZYod0sY6LoqzWdW5xat+E6XPc3IrrvAmmweHF0cbhEwEAzC70Znw245Spa+9SujX/HNKJ035JBK3YRNHwmu0xg9AM8YdhQUimnHxz9dVFwXs9sTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+pckJ/O5Gf5q7XVZrGIYCY66Fv0BViRvYp+3wkewKg=;
 b=H9bJUpT3CdVnP29xHUIauA39KXKkZV2LL3dDVGVwqMD6RizlTF9BxoTIHM1e2ZDz+Fjpn3jnoxFW5pmqTl93k7pXOhRirJ775VDee9m5u6UtM4OamK4k8t0tvcqH53OCwcdhy+/VupnyRPPGlAAF4sm28TtMDbOLigVyHTz0xd345X42W1mDOrEq7x84hfT+5JVaOxeU/m+gV5IR0N0ZglTgTYtu+tHQl6HjYiwUaVI6e08FJEzGRDwkE/n0v0mMbYW06bGO7dEnXqpHa874lSa/gv1WZx1Y9wIrgMLWLwRJTI0R4NIl45dWL3TiV3o7aiy//DNx9F6O1IPEC3T99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+pckJ/O5Gf5q7XVZrGIYCY66Fv0BViRvYp+3wkewKg=;
 b=MPg80LE9DkdHbxetuVOSY+7ATqSqWDUCM80wRx85jmzmn+qC9ZMLco07+ck1aiOmUBkEHMTnmHdqzdnlXumat75lxEPfFngLIeC1T20aeCNg4Tk0QaXJ3ZHdobbxlUKbSjyAEOf4baTTuzzc1xr70rKuitmxO2T++SI3xBcsiGY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:15:44 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:15:44 +0000
Message-ID: <66544b69-859a-4523-a0c2-57f8c3b89085@oracle.com>
Date: Wed, 24 Sep 2025 14:15:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/8] migration: multi-mode notifier
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-2-git-send-email-steven.sistare@oracle.com>
 <d5731248-c3f8-413b-a2bd-3326df7e65f3@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d5731248-c3f8-413b-a2bd-3326df7e65f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:510:4::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: e635bcd0-b832-4843-6e41-08ddfb9660db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTljSHB0VGx6c0Y1QnFRbjEyZDRzcDZORnNwMy81WTFSUHgxQUFQN1dQZzZ6?=
 =?utf-8?B?YWZLMXliVnppR3NNd3VaZzZJUWg5VmxyMldaS2VKOWV3VFdOZXlhRERlUmFt?=
 =?utf-8?B?SGh6aVQ1eFVXeDNmeGpkcEh3RmYxN0o5dGhRNkZiUkR1Y2VuM3NkKzU2bGxy?=
 =?utf-8?B?cThVZlMzbTRNekY2d2V5Z09uczJVam5kSHhzdkt5enZzaVk5RHVwUGZFVnJ6?=
 =?utf-8?B?STBYRWlKOE1nWjdCN2lqMk1KaGNaVE5PUlBTZVRPWDhlUFFna2pDYWFkcXpy?=
 =?utf-8?B?SDlVVjBPckkzaGwwRTZraVQ3SEdEVml6bW4vNldob1haRUdrWUNCNWg2a0dl?=
 =?utf-8?B?MGdnejdEa2lWVzJ2U0R2eWhDVlpqZ1E5RFVEc2lpdUNUbVJ0OHhGbkxoOVFX?=
 =?utf-8?B?TkR1VzJlaCtjTjgwNDhvOXdGYWNheXo5cEs5dkZMbGdBQWZoZk9Yc0NYOUxP?=
 =?utf-8?B?TTRKQ1ZoU1pmZDlhSU0xUDRmTVBMdnlsRTBHSytVbWNZbTNNV1ZQaCtTUDMr?=
 =?utf-8?B?Y1Yva2pobG9CaHlVTnRXNkl2MmJXbVFHeGZMd0RPbTJiV1JRZU9pMHVyUU42?=
 =?utf-8?B?U0NIRS9sTnQwTzRxdUFRNzdIWU5iTDlscEZEM3l3WFRJc2NvSHc2djJWZ05u?=
 =?utf-8?B?cXJSTUFTQmhtM3NISFZ4dDg4T2FURXppSDBQZHVvQ05ycWN3Tk1zU3lGY0dl?=
 =?utf-8?B?STJPOEN0U2FmYlVtK2lYR3RUWkdrTlduV3lDZm1sVTF1UitXTkxFRUFEZHdO?=
 =?utf-8?B?OWtscmxnZDBqWU5rQklIUVhVeDFCVy9yRklJSXgxS1dXK3pudEFzZkVyTmJm?=
 =?utf-8?B?VjNmcHpOUCthcm8zT3VSUDNuNHR6Z25IUWl4eitoTWdRRjZDSmI0cnVKVXds?=
 =?utf-8?B?dmN4VFNYR25Jd3Z3cnhkYTVQQzBoc054bVpFVHR6Zys2dG9SeW9EbTJGZklr?=
 =?utf-8?B?cy9tQnIxZ1QwNFY3UzRLTTJSNmkzcFJYcytBM1NlMUozM2kyeElPK0NyeHhS?=
 =?utf-8?B?azg5ZzFLcXdkczZSNFdyWm5zNGJzaTN6MXUxWmhYd0UxYWxRdEtVbFVaL3JI?=
 =?utf-8?B?b2srclhtVE9Dbll0cjF2M2tabjI1bjdZeXd5bTQ4blZNNWZoZUF2VWlOUVRV?=
 =?utf-8?B?QnkwelRkWFAyUmN4dTdDc29aT3RhMWg5dzVubjhYWjVlQ1RaNmxPRkZLVjNr?=
 =?utf-8?B?U3FzNXFUZTc1UXRIQ2xBTTJDaVB1R2RNakJMZUlxVVBHK2MwazdyeGRJZWds?=
 =?utf-8?B?QWJ1VHNnSTFyaDA1VHZabGRRb3dNbUVnNkxZd25DWWYyU3BybURIZ3JoU1JQ?=
 =?utf-8?B?bUFydXU3dFhMbVIwenF1RWxIVGFwQ0tvM3VjR1kzMlFZc3RYM3JDZmtUWjV4?=
 =?utf-8?B?ZldKeVEwY285d1ZmRkQzbDdINXZxOUtRdHkwWlVJNkh6dVpUT3A4em9rdlFS?=
 =?utf-8?B?M29Ham1yelovR0J0VFFzTnpOYmJBbHR3UFRmSGRCRW5ialhSN3dDMzBYYUQ0?=
 =?utf-8?B?USsrOUF0RFhxdjFCdDZTN0ltZEttWHR1OE51c3pnWUJ6UGkxMHZoS0NKRnUw?=
 =?utf-8?B?c2tBSi9YVTFzZmdVaUFtajF6Y3hEVm9mdE12RVU1RGRyYVB2N0Z2ZldSNm8z?=
 =?utf-8?B?NmcrRExSbU9GbnJLYTY2U3dabVViY2xyTzhhZHJiL1pjdDJUb2hJVHg2cmRl?=
 =?utf-8?B?SVZqaFVKUG9ockhHZFMraTVoYjlONlVKWVpVTGYvVHdTT21UOXFTNlNwNXdy?=
 =?utf-8?B?aHcwbGZxdUhoVTlrZDhrSHVFM3RDeEtwYUlvOUhrdW5xbmY2TDY1V1RWYjd6?=
 =?utf-8?B?aDZyZVNsOTZ5OStFcVBKaHlaN1drNFY4OHowbkZqc3NMWG9jNktuTmFQQ2FS?=
 =?utf-8?B?ZXNjY1pDSTlmYStSSWovMTFWU2cxTnZGYUhDcG5KVjBuN0RxQkFjall1alN1?=
 =?utf-8?Q?cH9cNBVwWwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZoajJZV2lKbjZMelJ3TmtxaXYzY0FGKzh3SVdGYVM1bzBZbyt2akJ6SndZ?=
 =?utf-8?B?cnN0dVlFU3dQNndubG9va1htRVd1S1lHckhvMVhPVDRxVjVhUERGeUIyRmZq?=
 =?utf-8?B?YzVrZllGZXlHR1JGSHp0L1hFTGJtU0tQamZ1SEk2bDdGdC8zbkNjaExGUER1?=
 =?utf-8?B?VUF2RDh6ZGo1RURaLzIvSE5JZUJrNFdqT1NtSWdHY3ZVY0xRa08ycjdhZFl4?=
 =?utf-8?B?Y0tVMVFKcTNGSS82S2swYUxuY1V4MERwaDFHWUllMk9PZGt1TW9lMlNIUWo3?=
 =?utf-8?B?NVZ1ZUQvbG9leFR1cDYxVnVwbnVsbkN3Z1JnY2swS1hLYzloTks2cGE0SG1I?=
 =?utf-8?B?czdwNmxTSVdDWEw4Uzl2YUFnZHpwM1Uvb1hYUXJKNmZIS0d4YTBtYXE4M2lY?=
 =?utf-8?B?WjE2aGdUTEFUeFE0QWlmc2Fkc3JzTEFpS0pYbk1QRmdmUHljZGw0NDJTTUV1?=
 =?utf-8?B?THFUU2wrTTNBdEp1T3Vkck91UDRRbEZ4N0Vvc0FINTIzdzZ0cGdMamRwdnZT?=
 =?utf-8?B?bVluMHAzWE80TzFCVjJvallOeC9xQmsxMS9VS2pmY0F4b1crUXJWc3JSM0JQ?=
 =?utf-8?B?N3dhbllVaFc0Z0VrNjFCZkpxSjE3NUIxbFMxMUZhRldPOWE4YzBHQXhGb2lv?=
 =?utf-8?B?V1oxRTgrZGYzZWpCZEFYSnp1Y3lnbWFKV0NwMHlWbFh4bTJ6bWlOR0FPZ0hL?=
 =?utf-8?B?Z0hRWjJLaHdQdVZMYUx4ejM0SmJPWW1za0ZWWEhjWVUraVU3d3RZK3ppQXha?=
 =?utf-8?B?NnlKWkRxVUFGYTI0K24zVnFvbnNiaUpQSmFHRjJrR21rcnRqOW93TUlHME8v?=
 =?utf-8?B?b0xNdm9mbGV4SC8rbmdzcTIzSXdsVlZHWTJSTWd4RUhOdVlYMVpSNGdhUWhw?=
 =?utf-8?B?N1FWajhiaEZIL3hYUXF0RlY2aWFxazU1d3lGVzlmbjRiM1ZkLzRWdllobkw1?=
 =?utf-8?B?WGtLM0hEVnUzYWFaT05kV2kvZFdIV1Jvdld4Tk9naGhyL0czV0lnOFdqMEpK?=
 =?utf-8?B?ZjlKaW5jM1FudU1Kc2NBeEFvcjZaL3dPQVQwRCtnVjdQZkprTFVySWtZRmx6?=
 =?utf-8?B?UXRzNk54YnpRRzRmbHVNVjg2YjlENmpKdXdoajdVcmdYbEhDMEJURDhDZnVV?=
 =?utf-8?B?WUIzZkthNWQ2akN3a1FGd3dHWmZVQ2xNRlc2enowcjdYSGZnQWtOZXRkK0Z2?=
 =?utf-8?B?c1RjWnlaK2M3RzExN3ozTVQzcmNFcXpxRHl5RytPMU83aitZelNrN2xMZENC?=
 =?utf-8?B?STV1WStvOWZleGpXdkMzODJtZDA2Vktxek1CaVRtWFVQRTZ5SnIxR3dvb0lv?=
 =?utf-8?B?YVlyR2dOdm5vK04xeWJWWXNzN1JSUlVLSHJWTDE2Y09BMFRQdkthdEpGZXR4?=
 =?utf-8?B?N1MyTERQOWtEOXpqSnRUbzFkRmlQMTN5UE9vZ05SMWVoTEhKYWVuRUhLN3FO?=
 =?utf-8?B?TGhwQmFGWTFkemdhNWg3b1o5eUZscFJpeVNoWlFEemZSQjBqUGNiNzVYM3Rz?=
 =?utf-8?B?UTZmdjJiYlFIZ1FPK3ArMVJhUkdBZ28vN0ozNGVLVlhLYnNmYU9ibFZnWHdL?=
 =?utf-8?B?a3JZbVRWZDRPRGY0SERUU04zYnlsbkRvVXdGRkhEMm9tQmtrWHNhd2pIWWNw?=
 =?utf-8?B?dXc3c1cxUWdmQkNsbVR3a2lsVjZ3c1dxTFQwZit3UTVjTWlDcE8rY1VjVklJ?=
 =?utf-8?B?MXJVUlVORlJTWk1pRi9xMVcwNWhscGtZUVNwUHlaMnVJd2ZRaDh4RXRvcGFE?=
 =?utf-8?B?L3RWZHZ5K1A4YlcyZGxGYkNGU1ArMnRzSzBuQktDaGJCN21COGkvVGF0Tjg0?=
 =?utf-8?B?U2RwTlhRNEhseE44cDBlaDR6UFQxeXllTjkrZTBJczJ4UG5nY3ZIdDMxQXAv?=
 =?utf-8?B?bjFtaVE5eHVGU0NOeldWeEV5MWVvSGJsV2hEM3l4N3V5czg3QnBzVS9CSGd6?=
 =?utf-8?B?dEcxNUlpUkVhTkh1aWVIM1dZSFFmeE9uTi9iOStaTFhUVGlIcHk1bGlYc001?=
 =?utf-8?B?Ulp5ZnYvL242NmxqNW1kRFBlaDJ0emRoMUlVZS9oT2ZHWVhqK2huVmNVbVY4?=
 =?utf-8?B?QWRaY2FZZTQ5YWZqN0ZSaU5XaU13S25sSmpEeGIyZndiMThZdjlGUVhJRjFy?=
 =?utf-8?B?bnllbURxVTlEc1FIdGtQNnI0UnJtSUdXYkxDbFNDcDJ2eVNncnRPSzA0SzV4?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EKd2aYBoQf78pzgxB9C1CirPyFY865SJ7GvOeHgKnczUfeZKXuQlAmlt1TXwhRzAODCG5LoWFtbB4M8av5VrvYE41XoWvFxVjjNZS2qtXZhpSXsa+DCBXtYMNsfl5QkM5Ru1a8dqR1dYBXen+f1F0mxGkgfEfl9KF5NB97q4MWXFu/vALokykpnqGGkUGb0CEX4S12tTELdDP6If5pCF1ym6I/urxDZCsQqK7ewIj9WPrtYY/5yVP89/pNFcld16RQSCrgiVOEHoS1IVFCHEhkCG5iPmasqWZAHxkusIkOW6l6nqhOgOLNepsxuwDULgW98NgC5/nAznAaM5X9exLaT5i6LqPo6Ssn7EsJ+h15Q5ImSK/he8UqHyPx1IdJoZt6CzNwuGyCoHk2VgPEaNbOUKutPPL2o4KwVdG9xtDi3BMORasf39StCAX9rcequYnc3RUOZzvI07XbONGGiPNAmM0PZgUtOtGZ0QZ3BoNhel6A2sj8mc6i7PTrNVvkC4jlc5DSPs+yUoztg/clzGFZ7h+Ng4JeplhBFLsKndvqcj3KD4M1huZ+1pUCoUj8iTtDgJ1jQy2nWN99FvEtdHyWyWaDXFDfR8TEhsBvgm6TI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e635bcd0-b832-4843-6e41-08ddfb9660db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:15:44.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN1/GTEk3VItoO5U0zDIuvKD9ww7BDp9EEvknN6fqOH0wP/NE1HYzGAfH+wCAAJdLD6ayxAF0DTZvLkPjNuppHha4l/bvoLjrBiPU7VAKs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509240158
X-Proofpoint-GUID: _UrsnJCvWSnKSZmu_HK3_JlOaJbaAE-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX7P2IBJaGfhG4
 2+rgF9kRkQVjgRJqf1UK5lXPLa3ixIZ37I3wMN97s7CD5V0EPmwkKe13qr9CwNVSRdPWAUAIFwq
 ZvpRgMbS4QTh4+NsmoAvKH2m5tWQCQWWrdPv2voyo8BE8De33KdcyLu2ZgfKKRlb+XcbN8HJLny
 5llErYH+TNOLpUKUCEjmLQ/iT0RWzt94W4rOzY1PSD3COlsUUx4QbpMbaaIc6mMEJb9zDCOp3IQ
 XNKkKkECFBhe4myjpNh1MSl6CDmv4En0zDBSa6ubmWbiInJHTbXTEnMLagS3Bv+VrAnn1wlTAQZ
 N4d0UMmpTdnPoTPlZFDq4wK25dRTeidfZpDBAptc8fSUipT34nswWOP1ggd2Zvs2UbNDmA9hpSr
 UQwBd0HnOe6XaAr+dUrEFcoajAp5/Q==
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d43554 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eUI86mzBRK8P03w_2r8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: _UrsnJCvWSnKSZmu_HK3_JlOaJbaAE-O
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/22/2025 11:18 AM, Cédric Le Goater wrote:
> On 9/22/25 15:49, Steve Sistare wrote:
>> Allow a notifier to be added for multiple migration modes.
>> To allow a notifier to appear on multiple per-node lists, use
>> a generic list type.  We can no longer use NotifierWithReturnList,
>> because it shoe horns the notifier onto a single list.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   include/migration/misc.h | 12 ++++++++++
>>   migration/migration.c    | 60 +++++++++++++++++++++++++++++++++++++-----------
>>   2 files changed, 59 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index a261f99..592b930 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
>>   void migration_add_notifier_mode(NotifierWithReturn *notify,
>>                                    MigrationNotifyFunc func, MigMode mode);
>> +/*
>> + * Same as migration_add_notifier, but applies to all @mode in the argument
>> + * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
>> + * the notifier is added for all modes.
>> + */
>> +void migration_add_notifier_modes(NotifierWithReturn *notify,
>> +                                  MigrationNotifyFunc func, MigMode mode, ...);
>> +
>> +/*
>> + * Remove a notifier from all modes.
>> + */
>>   void migration_remove_notifier(NotifierWithReturn *notify);
>> +
>>   void migration_file_set_error(int ret, Error *err);
> 
> I think the include/migration/misc.h file should be updated with
> proper documentation, like found in include/migration/blocker.h.
> 
>>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 10c216d..08a98f7 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -74,11 +74,7 @@
>>   #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>> -static NotifierWithReturnList migration_state_notifiers[] = {
>> -    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
>> -    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
>> -    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
>> -};
>> +static GSList *migration_state_notifiers[MIG_MODE__MAX];
>>   /* Messages sent on the return path from destination to source */
>>   enum mig_rp_message_type {
>> @@ -1665,23 +1661,51 @@ void migration_cancel(void)
>>       }
>>   }
>> +static int get_modes(MigMode mode, va_list ap);
>> +
>> +static void add_notifiers(NotifierWithReturn *notify, int modes)
>> +{
>> +    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +        if (modes & BIT(mode)) {
>> +            migration_state_notifiers[mode] =
>> +                g_slist_prepend(migration_state_notifiers[mode], notify);
>> +        }
>> +    }
>> +}
>> +
>> +void migration_add_notifier_modes(NotifierWithReturn *notify,
>> +                                  MigrationNotifyFunc func, MigMode mode, ...)
>> +{
>> +    int modes;
>> +    va_list ap;
>> +
>> +    va_start(ap, mode);
>> +    modes = get_modes(mode, ap);
>> +    va_end(ap);
> 
> No sanity check needed ? Could we have conflicting modes ? Just asking.

No conflicts.  A notifier can apply to one or more nodes.  Only the caller
knows what is necessary.

- Steve

>> +    notify->notify = (NotifierWithReturnFunc)func;
>> +    add_notifiers(notify, modes);
>> +}
>> +
>>   void migration_add_notifier_mode(NotifierWithReturn *notify,
>>                                    MigrationNotifyFunc func, MigMode mode)
>>   {
>> -    notify->notify = (NotifierWithReturnFunc)func;
>> -    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
>> +    migration_add_notifier_modes(notify, func, mode, -1);
>>   }
>>   void migration_add_notifier(NotifierWithReturn *notify,
>>                               MigrationNotifyFunc func)
>>   {
>> -    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
>> +    migration_add_notifier_modes(notify, func, MIG_MODE_NORMAL, -1);
>>   }
>>   void migration_remove_notifier(NotifierWithReturn *notify)
>>   {
>>       if (notify->notify) {
>> -        notifier_with_return_remove(notify);
>> +        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +            migration_blockers[mode] =
>> +                g_slist_remove(migration_state_notifiers[mode], notify);
>> +        }
>>           notify->notify = NULL;
>>       }
>>   }
>> @@ -1691,13 +1715,23 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>>   {
>>       MigMode mode = s->parameters.mode;
>>       MigrationEvent e;
>> +    NotifierWithReturn *notifier;
>> +    GSList *elem, *next;
>>       int ret;
>>       e.type = type;
>> -    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
>> -                                           &e, errp);
>> -    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
>> -    return ret;
>> +
>> +    for (elem = migration_state_notifiers[mode]; elem; elem = next) {
>> +        next = elem->next;
>> +        notifier = (NotifierWithReturn *)elem->data;
>> +        ret = notifier->notify(notifier, &e, errp);
>> +        if (ret) {
>> +            assert(type == MIG_EVENT_PRECOPY_SETUP);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>>   }
>>   bool migration_has_failed(MigrationState *s)
> 


