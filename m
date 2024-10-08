Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE760CEFC42
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFec-0001wt-Oa; Tue, 08 Oct 2024 15:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFeR-0001sI-6F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:13:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFeP-0004XE-CZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:13:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JBaAN004128;
 Tue, 8 Oct 2024 19:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+vlWk9GDh57fdUR+qnmL5tcJjM1x4XzhZK4mnVdF4KI=; b=
 khOVIDiC+pbt0XzEAQx6QeWIbeK2zU98F/E2ZLYULwLtDRxhWBqL0/CRh/Za7TC+
 zyEE5kLe8/ZtP9WzDoYYmcdebQOfOpCDOImMP9N7JkCHZUSUpLHjRR8ZFMh4CfYf
 At4wk0tIRTKZii5oTTAdMr0k5cxC0x7wJA+gA8ktiTZJSFQUUYGKe3z4piEwIRNA
 48pFi2Up6CxG6tFXILqW6ohYTaC9vQQytOdR1tegWyPwDXgMFo4PmhVgR4M640gg
 gr8ZnjJI92WTIwEsBjvCuDXpzxNlNIaMu46IV2YIpFKQpyjjBmulU6OO0g2F9cpT
 wcPWpMboZq9ZrpCNQz5ftg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yemg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:13:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498IuHWN038446; Tue, 8 Oct 2024 19:13:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7nu79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NORGMBPyJ5Yy7CKAA0jG2BJpVHyjuzinocqQTAtHFE0NPk0ftDAY2UZga2sVgcW+JRs+F4ON4lbzytAQ2UJgcE+mij2jygEmYpBPbsPqzcxU+zvFBIegNviwawFd2bx2d7DX0MqxQ+7iWNxEyVf31LnWPbBymXcA1vW38fZplfSFsvOco1wPJM0A5YBq8V/ZvCgONWs7bRv6B2j1pFA1kuh3nptv5/lo5gmbXDd79AQ3llhDQm04nqVEmnyzCIoKp4VaUYE9C2CoQ6NvjGfoEDlY7DfaZcwMxJGgjUoAN5GZdO7AUSflTRxie7XGE83Ql8Z1Qksi1FAc64TOCp1YWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vlWk9GDh57fdUR+qnmL5tcJjM1x4XzhZK4mnVdF4KI=;
 b=y5EP1aO3MSJzfMacvv5QKqUl33OPVqa+FBLJcPBUxt/03Ql89gJ2Docc0HcUs0pakF58Gbh3HDduxw4WDHJZYqX+kLNRjorG5O/Z0VAY4dvYbNhulFznXwxtK9/obPdPMnPpcuIUKdbWzvfOeR/2W4dvXhpAp4MyfQKrYO75xsDq1cgAfhwwTsg/BkIsuSMpkRyB0XFThpLNrj0JobtBQ2engdgbKiD2y8uxG67AVOQbSxL0KkDxdsgho3vme3E9n9h4vMBzP9YC0aLik9Gvf7m6grcLQ5DI3vLugQb2cxNW6TyzhO4pmqBUr26peh/Dj4/Tdv6jttEIDZPgeUblLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vlWk9GDh57fdUR+qnmL5tcJjM1x4XzhZK4mnVdF4KI=;
 b=z4OI1ENM6xGu1jdMj4eYLeunz8iyxDCTNp9nDEzTmDSHBzl8ldQeIgrqGL9KCdr+YkY6S/+g+3w04FzQfYkPMvBQ6DuAhBRV4H81+vljYzB0UMazUXHkMD0qpXnU9O1bm6+8symuD87idJuJujNca5+D4PrBZP9VMVfqP5Ni7bY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 19:13:31 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:13:31 +0000
Message-ID: <4775aeba-c54a-442e-beae-07c375ed6c49@oracle.com>
Date: Tue, 8 Oct 2024 15:13:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/13] migration: stop vm earlier for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-5-git-send-email-steven.sistare@oracle.com>
 <ZwP9ynimqzlmJ3uT@x1n> <17296eae-6d66-44c9-8355-39ad6a517a87@oracle.com>
 <ZwVRKKMYnfB1OqFQ@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwVRKKMYnfB1OqFQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6171a95f-1d34-4b9b-d728-08dce7cd4c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXFiaEh5Mk90d2ZVaHg0ZjF3YmxOSmsyeGwvWGQ4ZjR1bmNwaEZkb3dEdDc4?=
 =?utf-8?B?alI1UmNabGRVWUQzQURGVnVacG5EakZ0anRUMUUyMlNOYTc1a0xiY3k4Yy9M?=
 =?utf-8?B?aFg2c0Z3YUpHVmVhQjFtV3EvZE91eGM3NndNTFE5MW80TWFJMmVrRDhYekx5?=
 =?utf-8?B?MEdlSDg1TXdQR3Fpd1JHaVpacElnOVBZa1k3V2YySmJTNm9NMlN1d1haaWZW?=
 =?utf-8?B?aGowVWZxSUczSXYzbU5KYjUxUDdUcmNrTFpCWmVGdzFMMjU2RHBHT2svRFlF?=
 =?utf-8?B?QnRDbkZSV1l4WE1FUGF0QUVaZWVmeTAyS3FCTGpKT2tPK3MyWFJnN0pOUDVC?=
 =?utf-8?B?a0VIbWtMQzZ0c2RvTnZqMjBiVXFSS1c0UkZkSlN6THhjMXF0Q0pqaEdQUFdT?=
 =?utf-8?B?ZVJmc3hXbmN3b2tZK0xYWEszTmlpaXhoTWdxMS8yenJCbkh5SUFJcTBUd3ZV?=
 =?utf-8?B?K3RzOTNvQ1ZEdEM1VmJJZ285K0V1Q2NWcmErdmNwbS8rKzNRTndZUngyekxJ?=
 =?utf-8?B?b1gzZ2gzTWUvUlNlTk1IVFNKaEZvbndxRmIrSGc5ejJoRTU3TFQrUVpLOXk5?=
 =?utf-8?B?ZW01VGNDT0hlMXBwSXVpUVFqVVBuQkJ6cENvS21hK0N1ZkhIcHVIQU5vVVRH?=
 =?utf-8?B?d25Nb0Nnd3ZpZ2NjdFBHellRS1FBQkFJYUZzZXlEQ2lkSGRPbmJCVklOUFd1?=
 =?utf-8?B?MGc2cVU1bGdFbURjTEJJRGRUM2poaVNxanUxb050VFprOThuWjVGUUxYaHFE?=
 =?utf-8?B?cnVWanYyM1ptUko4Q3cvNk9BaVlmZVVZVkd2WWRyNDRSVEpiWURxc0tZTFhE?=
 =?utf-8?B?eERWSVVhcFBUdjF0Ymd6blZ4SWhMZUpMMHphSjBNNXU3L3UxVUl1amZlVjVa?=
 =?utf-8?B?b2xDUmNLNzFhaEJmWU4vUEV1bTVuZDRRV0N1YkJxVFdza2hQd2c3QU5YM24x?=
 =?utf-8?B?TG1xam5xVVMzdFhBVlZsbytua3hqd0JnMXBwVXQzV1M4MUdqZ01yZW9wNkh5?=
 =?utf-8?B?WC9mTjZxT0l1RjJFQVZpdVgwM3I1dDJtaHZWUGl6UGxQRk5LdHNHN2pVemZ2?=
 =?utf-8?B?T2xYRXBGd3kzVTNNaUtHNkxjTnNnVml2Y1hoL09zY3RBY3B5QUQ2bUgzU1Mz?=
 =?utf-8?B?TVRqUUJQcG5QSmxKQVpwcTVQZ1h4Y2ltUjlNTVZBRlpTWSsvQXpUdXlCWXhB?=
 =?utf-8?B?Nk5yM2tJbk1UOENuS2o5OUlUamtFellPL2srNEJSdWU5NEEyUVpaeWtuLzBB?=
 =?utf-8?B?WmlqSlJOK2VNNmw0ajl6dlJzZnkwSWxpMEw4Qm8xNVAxajVQM3BNc2RTUDlw?=
 =?utf-8?B?VUhjYVZVdC92cFdjaStHa2w5QmpNMldlWCs1ZWVFWjVhUmE0VXNLbVY1RXVp?=
 =?utf-8?B?OFZldGRuWVU5Wkl6d3FkOGlzc2NENE9NWVlhUlMwbHc2SE1heEd6NEEyTy9K?=
 =?utf-8?B?d0ZISiszK3phYTROT2sxeC9Ub2JtOVZPS3BOdjJjZFlaNWN5bDJob3l5UFNx?=
 =?utf-8?B?K01EYUhDcFJVbVd6SHdTQkNBMVB0OFUrNGNQS2xvT0h1TmVoZllSK1NwWjVX?=
 =?utf-8?B?ZXQ3dU1jTlBEd2lVZVFYSXlmaitIaE9aQ3Y1MTRiQjZlRDJRTWZyalVlN1hp?=
 =?utf-8?B?MklNVDlsUjNZSERqTmJlTG4vRys4d3pzWG5ickpBd3FpSmdtZHV5S2luL2ov?=
 =?utf-8?B?RE9tZXpGcnB3L0ZMUjgvNDd3UGw2bWRTNHIwZVZmRmZOcFJnYTIzK2F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURsMFltU1pKTjU1aERmYk5sUVBaZWZZNUFhTG04Q3QrMFB2WWNRQlF1b2JE?=
 =?utf-8?B?OFJLSVFxNjFJbEUxK1J0d2ZCbXVmd1RBUnZVOG81TFBMbEY4UDRLaWRrUXo5?=
 =?utf-8?B?THI0RjJIVDJQUWR5b2ZuT29vaGJscFZOSURsbEV1TjBxYXdyUlBIZjdYeS9I?=
 =?utf-8?B?QUtrT3Z2VmJxa2YrTWNtdE9aMXZhNUthZzArOWhzcFpvRWxqcWJQNDRtOGNq?=
 =?utf-8?B?VTJjYk4xTXIxTUExZDhNa1c3by9qWVBBQnNyUEpMM2hqS2NLVFduNkhVZ0p5?=
 =?utf-8?B?NzRmVHFLcWtpakE0RE54RXRLazMxa081VWZUamFQbE9EN1VTVnFUUUIrdmxC?=
 =?utf-8?B?N1hrUzdxdmRNVkNGUEo5Yy9qMmcwMVk1SXJ6TS9ibyt1UDEzd0VXVGZITFRu?=
 =?utf-8?B?OWxGS1ZwYU03a3JwckRSeW1ZMmswQTYzQ3VwNXNwa1BaS29qcjJURnZCLzRP?=
 =?utf-8?B?bmxPNWFIdDhid0tIZXlSK3pyUFRBendGZXhTMWpSbXExZXZNdjlMM1FWd1I4?=
 =?utf-8?B?eGJFN3MzQ3oxNThsdHpEbXVjeUtNVmxOT01idkUyU1ptbWxZNGNDOGlMQjhE?=
 =?utf-8?B?NHgxUHUxYkJoVks0ZE93SDJFV3BHSUs5MXJJcVZIbTJXQWtqUnU3WS9KemNy?=
 =?utf-8?B?QldLU2diMXkxc2YxMGEwWFZzQzNUdVBEcmRXUDlPMFlrVVNGTFhsVW9XYlI5?=
 =?utf-8?B?UDN6TmxUd0dYSHRxVW5NU1FON1l4dzVxR1pvWjZVUWpYTkFUcHRGOXZvQVBh?=
 =?utf-8?B?WFVqRXpaUmVZSUdSSjVWUXVpNzRrcVBMcjFPRzY0OEczK2dNVEJPdzhDbmJQ?=
 =?utf-8?B?b09uckxJNndQRkJ1Mm1saVNPclZrMnVvMXhYWEpOdzFpbW43cFpFUGNXUmUx?=
 =?utf-8?B?SzRZd3NrSDVoUE5ESmRhQ1V2RzZ1UXVwT2lteEhITkkxTU1HL3R1ZGdMSTdU?=
 =?utf-8?B?ZXVtVkQ3UUQvTzBTb2UwZU9Ec0F6S2xUbVVDUWcwTTB4MHl4c3hGT1IyS0VO?=
 =?utf-8?B?ekhQR09PMlVRd2h3Z3JsNTNuQXRudElYV0tLS29Idkt1YVozNG5scXdrL1Vw?=
 =?utf-8?B?V1lmcnNVSEJSV2Y3bmx2bXhWTm1ocDJWSi9hSFFTT1ZMYlBUVmJOZkxRTzc3?=
 =?utf-8?B?cHk2Qnpsc1J1bHQ5dnhkN1ZVRFJhcXFWYVFTbHhKQWxVbk4vR2VpRi9DNUpP?=
 =?utf-8?B?YUZsMnBSYURCWkNFK01RQjBNVzBPV2JVTlNwWGU5ZE8zOWlzV0R2dUt2M3A2?=
 =?utf-8?B?TlJ5QTFaSlJHRFpVRkZCdjI0R3l5N2twZlJVQkoydEJkdG5KcUlNT00ybEs3?=
 =?utf-8?B?ZGhmalRDR01YL3BySUhkbUVTZHVpRlNURitrUGM0Z0UxUExQR3lRMjFWQkw4?=
 =?utf-8?B?RFhscmk0QUtRNEZ2all3WW9waTJDaHU4b2VFRkRDTkZIRUpqdndmY05YelNh?=
 =?utf-8?B?ZXVTV0dPUHNaaTBrdGNIME1WaTNFSmNnakM5MU5GYnltSHJ6Z2xITkJiVldL?=
 =?utf-8?B?VmFQSkpKWlhBWjlpRTF3eTVhZFZIaFdtOTNKd3BTdGNhSTJHOWVmUjF4bXBr?=
 =?utf-8?B?QzlCNVNITUZZRTdIQ0FxQThXTEVyY2xENmFjanZ2dVkrVys0ZThiVFBrcjJ6?=
 =?utf-8?B?OGEzVGllUWVyK2Y5TlBQOTNuRnJrNCs2eFh3YVEzaHAxbGY1eVlmUTduRTFE?=
 =?utf-8?B?SDhWMmpxTXluNzR1ODNnc0duZ2d6Qkt3S1M4cHlBME1ua1lwTG53anpTZVJI?=
 =?utf-8?B?WmZVSWN2aWtPRWZyVVdLWmZrRlVzWVYrU2VPMDJhSDl3NjZuVldoWGZ0KzA2?=
 =?utf-8?B?WURLaVlxZTQwcjZUdlRJKzNBbm5oL1V5K0xZb1g1M2V1amxjei84M2ZubVUw?=
 =?utf-8?B?dVUvb3dvNGQxZ3hYZGZFUFV0eXZlKzM3OU1tS3BYZW9yblJJenFnYzZMeU5Q?=
 =?utf-8?B?SmpJSXIrRnlOeHZVOXVacDZENlV6Nk8za2FtVmIwQk4rMTJicmFoOUQrOUtn?=
 =?utf-8?B?YXRFMmZxWHRBK3VBdC9uMmxYay9oZlkyVzUwOTBZQ1Qza0kwTXhtUWJCamN0?=
 =?utf-8?B?ZDFGdUlUM0ZOcHNGQkNsS0xaWVFHRGFiRXVuSW1jbTVvUEhjdmJ4MUZDeWN6?=
 =?utf-8?B?Um0rUDcrVE40dldYeHgvdXAwaGkzMGdDZjhpdVFYZXZCaTEwa3VFTFRZYTlQ?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xdvqt0NdU922lH9H80l9rxUVfJ15HFf0ZfmcdFTLN1IA5N5qm/5qZMzX+ikKd+tzr+RXLW6BlcPB6X8RcjgsFWwTK8AlchkbxfSuzNPSry2y/lzcakPoELJInsuXTRO9NEm/Q5EzTdBuuZzJhrsI6fN2DxhioUnFJSlSHXRgoH62lt6CqeoCbDBOKDMrtJ/0Od4Re+L3ecNNx5rilu/LLdjBHKl/2MbttMkWLtGtTvGo4pkK3Uhm5I+d+qUZQzmu1vbEu4zY3YXIJ/PV6if6H0rF5cTM++QLk+Zyk8LLD/W3YNdn7Rz8ouV5pmGgKhipkogYVTUKvtRTSsk37/7xYJH2f/UfP/YSEBXKxfuwO87sgIEyR2wMPn/1iB5KK66YAGqvWZcsjiuZ4fFVUoafzkHxs0orSNaM9t83NeTre44e2yAFCe0tXFEUmjDpH466LaelVY5DzzxnCyXPqtudR2FRVWC20uIJGkLP31Ku75m9aVO2iFA1MfQao8xnRykip4KOp1p6ShnBuelTbyj5Qq6HgV2Gvat8NVZWi7SC/tkEh9tq1ioVrw7Oi5plxVPVylOz/TyBG5pY4p96QA2Duk/B3kOD8khCW7XypR+ctH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6171a95f-1d34-4b9b-d728-08dce7cd4c11
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:13:31.1786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uLVRW91Y7ekkkwEPHIgdhpbd3quvORg17J7kX2+IKSiPIXNK8uqAqMlMHLFRDyizupPXcO7kHfQ/wybrzoiA4yxaW3GqS7ceGGFsdSx9VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_17,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080123
X-Proofpoint-ORIG-GUID: x6pL1uea9Q21lpNUQL7HW0lSn4gSEPU5
X-Proofpoint-GUID: x6pL1uea9Q21lpNUQL7HW0lSn4gSEPU5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/8/2024 11:35 AM, Peter Xu wrote:
> On Mon, Oct 07, 2024 at 04:52:43PM -0400, Steven Sistare wrote:
>> On 10/7/2024 11:27 AM, Peter Xu wrote:
>>> On Mon, Sep 30, 2024 at 12:40:35PM -0700, Steve Sistare wrote:
>>>> Stop the vm earlier for cpr, to guarantee consistent device state when
>>>> CPR state is saved.
>>>
>>> Could you add some more info on why this order matters?
>>>
>>> E.g., qmp_migrate should switch migration state machine to SETUP, while
>>> this path holds BQL, I think it means there's no way devices got hot added
>>> concurrently of the whole process.
>>>
>>> Would other things change in the cpr states (name, fd, etc.)?  It'll be
>>> great to mention these details in the commit message.
>>
>> Because of the new cpr-state save operation needed by this mode,
>> I created this patch to be future proof.  Performing a save operation while
>> the machine is running is asking for trouble.  But right now, I am not aware
>> of any specific issues.
>>
>> Later in the "tap and vhost" series there is another reason to stop the vm here and
>> save cpr state, because the devices must be stopped in old qemu before they
>> are initialized in new qemu.  If you are curious, see the 2 patches I attached
>> to the email at
>>    https://lore.kernel.org/qemu-devel/fa95c40d-b5e5-41eb-bba7-7842bca2f73e@oracle.com/
>> But, that has nothing to do with the contents of cpr state.
> 
> Then I suggest we leave this patch to the vhost/tap series, then please
> document clearly in the commit mesasge on why this is needed.  Linking to
> that discussion thread could work too.

OK.

> Side note: I saw you have MIG_EVENT_PRECOPY_CPR_SETUP in you own tree, I
> wonder whether we could reuse MIG_EVENT_PRECOPY_SETUP by moving it earlier
> in qmp_migrate().  After all CPR-* notifiers are already registered
> separately with the list of migration_state_notifiers[], so I suppose it'll
> service the same purpose.  But we can discuss that later.

Sure, we can discuss later (and I'll take another look before posting the vhost/tap
series).

- Steve


