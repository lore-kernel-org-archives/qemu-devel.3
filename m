Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30B6C54795
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2mn-00061k-5x; Mon, 19 May 2025 11:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2mk-00061W-T4
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2mi-0000Uo-PZ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEXFvq013455;
 Mon, 19 May 2025 15:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=xga3ABOeiWmC+9rK9mIZQ4ZSsBpszHPmS8hKwo+xFwg=; b=
 dYhR53XQF8Q0Dfs/YXKR54stvI4Cc7vMz9xXHVfniTr0KwQ/jHNZVF3C7BbqU9Jy
 X3tqLep3BJb/QtzvhwXV5hqBrTdPCAkk58Q7HGTgO8ABnpBQ2Mt9fWg94/PKM0bW
 5kEzn57ArXK8BgIGkRWTkSpUzTipqOFvHDbxS5y+ojVj6DtFD9UTcRHxuo6n7cKb
 v1WkUXWYSgD3zAUArA5WPnT1vkPzk49JLJ4TXE7fwYWSTMMVRBj8/w5+KJazCM2B
 WkuaJf6IrLcCYla0v4zpEVkVgjPMFNfVhAHprlZ/qGtIcA9O5AbpcQ8z6JQIw+VA
 1cE0si/fsSb9REDrUnoT9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph23bdv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:52:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JFAZQk028839; Mon, 19 May 2025 15:52:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6uvbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxQgGNhKlCj1b1wU+fl3eEkJewnwqzffJ1yvBCEK8vpR5RyOBSpsKj+dmRXGOTeLIWWLEkLqD1Vnnol7j1VfJeFNdyeEVndAWqcF22YkTFZ/4/AQIJgi0eBOpzElg6AI0BI+6AajPbPUm22Czw+SFUUYJpKExQDLjssE3g/SNCNQ8VWjQ6dLASDbedTsulsQBeDIv0gGNcyIsQL9eQwEDcrebV8Ok2f1uE59PTTCGHUsV8jmYdxxNBJwAulI3t0zVDKvVeLvpXrgVU1wJzVfWf8mkkVrqydI7nZlDprrbxsz5xJrzfUC7irnEQi+JOIX0XQm1/VaIAQ+bmVJLAYY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xga3ABOeiWmC+9rK9mIZQ4ZSsBpszHPmS8hKwo+xFwg=;
 b=wwQIMUJrsc7hgpxRdXrDIQmivr+KRA7e8zVDBtgEn5OZae01JopoDKCPO7hyzp/dA4hwmgwbo0b+RJ65NlsLnD0/OkI1Qs+CsCzAx8sfahTDuI8ACsCpwggVLRiJ0TtkPrDBdM69ZGAOxqNZA1PgI3mjsXKUPfxkbnLxDG8m2gTH/Y5QMUr6ktotUfKE2gSSF/yxhqvfwm87pX8dZd759qI+yrsxZ+Y3JF+Z0Ir4vi0KzxAgu0rFOKv8NldtzI6LDbSzI6E2f/7RwEH8Xgl6u7Z0ySU2FvRB1ETA9dDpxa8rh3T35GrFWxQkkbdII9hw/7t4tIOtZ4O4jddcghQZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xga3ABOeiWmC+9rK9mIZQ4ZSsBpszHPmS8hKwo+xFwg=;
 b=WNlFDeGiEHCM47rCqzwg0Mm2oCea9GlXdBpQDE0Z33/chGte0bhczODLLp9tGgqwYT9qP31zxmBT5xGm5cbSZG7QcJIrWE8PrGJ9iGZrUk1AhwTkZI9OwjISuGhlMTXljsf/8H/O6ORWGJlcJNrM6LohLBUv/dfTtZUKYfv/xCo=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 15:52:06 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:52:06 +0000
Message-ID: <bed13219-6c24-4f51-86d2-923909d5b18e@oracle.com>
Date: Mon, 19 May 2025 11:52:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744E4675DF4622F4414F5B49293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744E4675DF4622F4414F5B49293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:208:23c::26) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6742edce-4d60-4d69-bfad-08dd96ed1b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1lFMm11bXRXMFg2WVliZDNHT1dQQWVSTmxHSEVneGp1WmdONjBRMFJranFI?=
 =?utf-8?B?bC9ndXcwOURlcjJmc0hOQkZBSGlvRXpZU1Y2cFJTcnRrMDEweGpheXRHR0hE?=
 =?utf-8?B?UUNZdndkTDNWbHJubk9nMzdZUWFCbDNaVytpVUZIUHpDVkhOaTB2czZZL3lz?=
 =?utf-8?B?YjdBTmc2dzBNR0QzWUxpRExhMVBZTjhrb0NFSHdiWnA2TjdtbHR5N2hRWkpV?=
 =?utf-8?B?bmRFUXFSNnRZUW95ZzVVYzErNWhaTk5zMVBscjl3QUhLUDZ3UWEybUxiSFN3?=
 =?utf-8?B?NHRNNmVmNksrek1xNWpQb1BOTS85SlQxNFE5WU84dk9CSjhLdVE4TjJUSjZT?=
 =?utf-8?B?djhyajUzKzZsMGlIeXJFWW5lc1lrK3FKc1QvSU9JVTA0RXIrM3E5TUhJREhy?=
 =?utf-8?B?UndxT2FraW02MG1GL1NGYkFpWURoNm5FME5OSkRXRHdLTEFYU01FZWVYb1pB?=
 =?utf-8?B?dzRIVVpzeXJhamhxbERLc0YxSmczakFocXlybitqbGQ3YkRSN3Z4R1lGYVFk?=
 =?utf-8?B?MmpiT2thSGtnZWFBWWt5Q21ETHNPWWNGWjg4K3ZBdXo3UWIxY1h4aFRjWHFp?=
 =?utf-8?B?MVFDdkxzTlJBdDQyV2d4RXJXM0ZkWkRXSVZoZ3NrRjJvd1hxTWlYTGdxYlFs?=
 =?utf-8?B?a2lvOFgrZ1B4dkRqVTlxdDBYUnNWQnEwU21JVlJUQVl5VG83NlB2OEVCd3Rw?=
 =?utf-8?B?bUJvcnZCRlRYK21WNXRjaUZ1N1dLaTZPc2wycVdkMHRnWThVRzY0eXYrYzRK?=
 =?utf-8?B?U01ETlVMekdGdWVjSXRGL3F5MVBDZWtnTDI3WmJUMGVxa1N2WmdWTVR1SVhU?=
 =?utf-8?B?TUpIcXNoKzRVWlJaQ2J2eEhuQUZKbXdYVDJaYmMzUzRPek9vaEl0RUNPazV0?=
 =?utf-8?B?bmxRb1BiMC9pS2ZzTjBOK2F4VDZsVFpsSTRWRmhybkRWSkpIMUNHMllUdjh1?=
 =?utf-8?B?bnpON2JVNlZpTk1JME5kZlFwME9iNWhXY3UrR1A4TjlZdCtPNm9xd1pMMXRs?=
 =?utf-8?B?VHJKcUtaSHRzNWlydUVnR3JwYXV4MUlnUFMzc1NJdnRzNnJYZk55M1Q2aGx3?=
 =?utf-8?B?SDVLUHJORVg3T0wwWjh2K0xVeGMvU2hpYkN4Z3R3WW5VUXlIU3FpSUpGbm1j?=
 =?utf-8?B?VTd0akhtSW8rditHYVJTenBFa1Q4WlZIZnFuenZFaVoxTFBaQlZOM3VxUVU2?=
 =?utf-8?B?VExTeHUxVFBZZjlKMEVGbEF3WEVHQVJNa0tBVTJYa29meXovMWIyNWpIbC9M?=
 =?utf-8?B?UUNoc2FEL0dqelNQYWZmM29LOW1uMjRFdFJuNDhER2Rhc2tBbnFGUm0wL1VS?=
 =?utf-8?B?VzQvWUFXeVRWaGR1ZlBKUmZET0l0b2FqWXBOMVRVQm41ZndmZmdRa21ibjBh?=
 =?utf-8?B?VytyQm4wK296U3d6Ly9SNmxUdUtGbDF0b08zU29QRi9vQWZvVTJhU2Y5c3lL?=
 =?utf-8?B?R29GOXMxYXJoYUNIalpVUWVQOERqUVVyTW5JK0w4OXB3UlFYNXNWcEVtemt2?=
 =?utf-8?B?bDZOcVFZZlFCSXJPc1haQVYvWnhibUlRSDVhTG1qVkZBd1ZPMlkzb1pGVXlz?=
 =?utf-8?B?RUxwaWptektmVjRrK053MXJMNFFUTDAvb3JkaDlKSUpLenp5bmhUTm5MUFdw?=
 =?utf-8?B?eHkzMGk0amp2bEtlcG83TjlFK3AzRjlmMGdaOGsxTGRMdUxzK3Rjald1SlRh?=
 =?utf-8?B?dXowRG9tQVg1ejhQR2NsRE1wUFRNK041dDJFM3hxa0lIKzdiUkUrSGlPZTZy?=
 =?utf-8?B?d0wyUVRIMlhFZk1zMFJYVm1wR1ZTM3ZlL3VCM3JaaW1DbXV4SjlXR0hKZU1T?=
 =?utf-8?B?Nkw2OW9aelNIZEZDUDVSSHpKaWprb29HbUtacEtiTUVOUE5obGppOUtkVE1r?=
 =?utf-8?B?TCs1T0duVmtlbWVPRGg5VTkwMFBCWDloOGt4RzZleU9CMFlxcldLQlFHZFJE?=
 =?utf-8?Q?rXXfe2uD2MU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1Qa3dTM0JsQ2tLeTRVU3Jxb3pubnQ4RXNtc3RWbHJGRG9ZbEF2ZG9hNVdF?=
 =?utf-8?B?TEFVS3I0SXRjbHptWlVxMjJIY0xHOUNvU2NWZDBDY3F1RXVOVDhabnhJQUdJ?=
 =?utf-8?B?dkJJaEI2bU0vZGRoT2hmUGVuNUN2VTVGZjZSSlB4MmhHMXVaNjUrTTRNaE9z?=
 =?utf-8?B?RHo4RGx0TkhyZ3ZqZ0JqcjVvUnlNOThZRHcxbkFIM3Y1NGxnMExJRlJKY3Ux?=
 =?utf-8?B?S2QyeXBrTFE0U0YxQzVYRHpJcE8ydlc0V3hlY1FsRmJ5eEJZcE1OQkxiSVIw?=
 =?utf-8?B?YTVYQ3pMZ0xCK3pXTkk4Q20yWjh2Lzl3bDkrTkdaSjR3eiswWFp1UEVWNGJ5?=
 =?utf-8?B?eUJlWUNucmlHOGkxb0hySW5IM0x0Z2V4dUNBMXY0TStWTitsT3REaU8wUnBt?=
 =?utf-8?B?bTJnNXZTalBGbXk0NStjcVV6NFMvOUo3c0lleVcxSGJIM084Q3I3TTVPWE8x?=
 =?utf-8?B?bVV2cE1heFEvNEFxQ0hWZEh3emYvU0FWa04zenB1aHpGcXdlQ3ZFc1A5ZWZV?=
 =?utf-8?B?M0cwd0xpcENPZ1ZBUE1YdENVME95TzU2QlJ0QmhPVEZqazdqOFJEc2UrSGJj?=
 =?utf-8?B?T04xZDc4MXp4TWtlZmw1YWpFQk9aYWNGamVzd1dzbmZIU0o2UDlINzJra211?=
 =?utf-8?B?RmcwY2YzQWlwRUFhU2g5TTcrekRmYkNBS1gvUi9Hb0ZXNzY4Q0tTNGErLzlu?=
 =?utf-8?B?VERHUmdSZEV6aVg4WWRJNDAyckZrTEhEUmExQURxQnRKeXZLT2Y3cmltcTkr?=
 =?utf-8?B?ZU92amZrbVZGbWRENmlPV3VBM3IvQ1dtWjA1MlJ3Zm1zQzdyY1JLTkhrNG1E?=
 =?utf-8?B?cTdGQWxWSmFaZXpUREMwbFByamljOTJvamFzQXNtS2d6eWxtaDg4WTg0NWkr?=
 =?utf-8?B?KytGMHpCcENXQVVPNUhSMmRwZGIwQTlqRjArSjFZYVl5WkRDeEVOcmpiZVpG?=
 =?utf-8?B?bSt6elRiWDM3TWpzM2VCQ2pjdHRLTWpiL2dsSFRjNHg0UW1iSXcvL2FBL21K?=
 =?utf-8?B?UWV3WFdmdkQxV2JtRVJOaTh4aEIxSnkxeWRMdEZrR09UZDQ3NWdlM2VFbHBL?=
 =?utf-8?B?bUZORjBpL0tJQVFtMUVhN1AyU3gwRFdDREhwYUhpSWlnODVNRG1LamV4OGpp?=
 =?utf-8?B?M2VaNE1KcllXOTE4Skd2Rmw1RWY3ZXBKbzkrQ3IxR3ordTFmUUZlS0o4azlQ?=
 =?utf-8?B?K2plMjQzNmM5OE1pWTBBWUZlYTZGYWpNSkhpZEY1bXV4RDZLT0ZHSm1rUFVP?=
 =?utf-8?B?dGx0TjZRZU5HbDIvaWdyV1pkN0N1Z1IyaVB5WTFPOGJab2krb3dnQkZkV0tU?=
 =?utf-8?B?eUZOd0RWeHRFMmxzc09yUVpaSEdMcnFYQzRWMWJ1aVRRMU94TkJrejV4aGpr?=
 =?utf-8?B?VUN6c0taSEtIR0xqQzRabUVRVXdoTGFZUHJtajV5MnlHUE4rWmY4LzJTbWFE?=
 =?utf-8?B?NVdjd0RNS1pGa2VOUkJXRlNNdHVSdk9mWERlZTIrK1BBb2Q0VjRoZFdER25W?=
 =?utf-8?B?clcvRjROZE8rdzM0ZXk1L3ZLWXZMVzlLSGJlUHZGNmNSaDh0NnRNTjVBZ2lM?=
 =?utf-8?B?NkpubzNKK1lGM1RBd04wUEpYTG13SkdVdGNUeEl2OEhMYWlUSTF2SzQ3OU9i?=
 =?utf-8?B?M1gwamlpSjdHa01NdW9Wakp6YkRvcTlIaEYrRGU1ZmJxY1VZOW5JemJJTFEx?=
 =?utf-8?B?Y1FyU0FrTHI5akRYcitOTDArWnE2Y1pNa0pYeXE0aWhQeDNRcUhBc2JEbFQ4?=
 =?utf-8?B?cHJJYjNpZ0pyYU9TbkRablZYN1J5Y2pSWUgzZmhHQnJxT3g4eklBTmRZTjRv?=
 =?utf-8?B?a0d2LzB0emFCVGMrTWpRc3dDNVFsa2JwQm1IMFBFdDdSUTNCSkNkd3pZdWFL?=
 =?utf-8?B?NHZsUEdFVFBvTG82c0g3UWo1VEZkaVlLWjVKbkV4d3luZkdsQ2NVWG5sS2d2?=
 =?utf-8?B?dit2NUNwek9YdU5kSjd6QjFVdnp2NmovUHkwcDRWdnpYeGFTV3ZFYXJXbzF2?=
 =?utf-8?B?bVpJM0tsZytkOUo1N3ZNVEQ3OG1WdXQwVFBUaFV2aFpaeHNWNnZCTVB0bWk0?=
 =?utf-8?B?ckdZbE05b1BwamJqVGNCS1BycWtyRDdOd2l3MTRFaDZ5S2RxWG0vYW5sOEpi?=
 =?utf-8?B?MmUwTVRPeFoxZlMyU3NicXJFMnNLWmpBMUx5WUEwR29XUkwzVmJRNWJvQXdC?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mfrSdOZuiv/pnqiLo5c1mWu/tTWcy9IN5Ut59jHd+OTH6zgj/VMWz9K38eqNZs54EW2qbQUBQdfhEx6/RQzLHyGHXcKZ+eJoFkDH8a0GjY8NCFlpcSPViqJrZo9peyxXHBSSvg+z+x5TSouTHEOT4sBd6tyidHDz2nWRBPQdZkZPgNnc0NEMbOsMlAZOFA0OMLjP6tES2HUvNhoyfymOE5eUlTJyiCSiwvOpym04iMUCtoyELQLtV7i+jOjdkAV/yIA20h43StkRVpZOWnAa/pLx+Eyj1M+Kuznw6VwsjYFuuK26xYKX2GVZ+W0FDFtTyBch77v/srgsJm9GjGh1dpza4WmlmbDmbpUqXGNelSaSoaEZFPjJwEa4QjmARFeslIua0eR9hlbtyBaDA687u1oHi23lS0yA56lqjC7v7bV2RBfINKYkgUqJCh+nYokyD3V0hYmcSqnOPkElonI+GE6Kc78VALCCPZ5eEePVut7XWFWWXflczgoJFO0EKxntIntE5VSgYUZm+KQZG6oQfW2J70k4hYMbddvduZWbeo0VfbrQrKYGsF4ZOpIVbVw5J1+Pj2IIl39vsIZueUk5RryEPkeJXDxpafCiqkl9tUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6742edce-4d60-4d69-bfad-08dd96ed1b0e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:52:06.3730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsDCpRFjN6kl27NjIzjxLDyqz7M9AkdL73uMtA6k+q0JNCyN2p+KhyzP4Cqr9sP8D5+db844YahEbmoRGP1vUUBO41nUR62UgtdeI3MUAVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190147
X-Authority-Analysis: v=2.4 cv=GN4IEvNK c=1 sm=1 tr=0 ts=682b53a9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=K9RUBsG0kB51XLgkOOwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QNH6HnRpzd8KJeyQ6Rz5G3AVcXhVS6w6
X-Proofpoint-GUID: QNH6HnRpzd8KJeyQ6Rz5G3AVcXhVS6w6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfXytuM6vhFUuul
 kRBdFFcNRpHbsM7lPyTs1nh9Upxhyt8pNbuW2YJVGuRt9FQRVU8n5SgHfWuXGqrgaqkTjaIV+3c
 wRw4IqjhqYnbOuAVIb2TqkkNjU30cCL8xW6rCWnYpeWh7QnDxAr3WRn3RlyG5AU7Oi5DFC0sXSp
 m/UtW7UU9yLOwTNVOkKsPM9vUUVVRjJK1iM2cffXi3inbOD08Pdy09931XLc+nLn8QTN+PHGxAn
 TRRXEamay5eLzH7yrRo2CLoYWD3oueYMvTeIBVvKzuNEjbEq1+hr4ScoksUuT3FIQBwyaYAljPA
 Rm1KrFA4KMuSIJ5qAoHMLfAoqywTY32ux0+0VYpGk8BgMp5D37ZknzLlgDjO3f10IMWDNfdXwpx
 FkEPSxUJK5VasBNSAYJ7pngneBXwYEiQz80oh7t/gF6DEtpGLnyk+pq6kSjT+WVRXjtKNkVd
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/16/2025 4:48 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>>
>> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
>> Such a mapping can be preserved without modification during CPR,
>> because it depends on the file's address space, which does not change,
>> rather than on the process's address space, which does change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/container-base.c              |  9 +++++++++
>> hw/vfio/iommufd.c                     | 13 +++++++++++++
>> include/hw/vfio/vfio-container-base.h |  3 +++
>> 3 files changed, 25 insertions(+)
>>
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 8f43bc8..72a51a6 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase
>> *bcontainer,
>>                             RAMBlock *rb)
>> {
>>      VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>>
>> +    if (mfd >= 0 && vioc->dma_map_file) {
>> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
>> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
>> +
>> +        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
>> +                           readonly);
> 
> Shouldn't we return result to call site?

Yes!  Good catch, thanks.

- Steve

>> +        return 0;
>> +    }
>>      g_assert(vioc->dma_map);
>>      return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>> }
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 167bda4..6eb417a 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -44,6 +44,18 @@ static int iommufd_cdev_map(const VFIOContainerBase
>> *bcontainer, hwaddr iova,
>>                                     iova, size, vaddr, readonly);
>> }
>>
>> +static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
>> +                                 hwaddr iova, ram_addr_t size,
>> +                                 int fd, unsigned long start, bool readonly)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +
>> +    return iommufd_backend_map_file_dma(container->be,
>> +                                        container->ioas_id,
>> +                                        iova, size, fd, start, readonly);
>> +}
>> +
>> static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>>                                hwaddr iova, ram_addr_t size,
>>                                IOMMUTLBEntry *iotlb, bool unmap_all)
>> @@ -802,6 +814,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass
>> *klass, const void *data)
>>      VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>>
>>      vioc->dma_map = iommufd_cdev_map;
>> +    vioc->dma_map_file = iommufd_cdev_map_file;
>>      vioc->dma_unmap = iommufd_cdev_unmap;
>>      vioc->attach_device = iommufd_cdev_attach;
>>      vioc->detach_device = iommufd_cdev_detach;
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index 03b3f9c..f30f828 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -123,6 +123,9 @@ struct VFIOIOMMUClass {
>>      int (*dma_map)(const VFIOContainerBase *bcontainer,
>>                     hwaddr iova, ram_addr_t size,
>>                     void *vaddr, bool readonly);
>> +    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
>> +                        hwaddr iova, ram_addr_t size,
>> +                        int fd, unsigned long start, bool readonly);
>>      /**
>>       * @dma_unmap
>>       *
>> --
>> 1.8.3.1
> 


