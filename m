Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6C606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=TsYCjxlA;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=hwu52xYX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQMS7-00010r-2X; Mon, 09 Nov 2026 05:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQMRd-0000yJ-LE; Mon, 09 Nov 2026 05:17:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQMRZ-0001ER-PU; Mon, 09 Nov 2026 05:17:44 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99uxRw1033090; Mon, 9 Nov 2026 02:17:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gNjjKSFP3Em4qkV7kA22wx3pE5CmLY4y5IPi2lcNm
 5E=; b=TsYCjxlAvvpTwqEE09riN5YPG8KRl4+o1Xx+c7/rkgpV+WYBKCxc2FHoB
 4798S+2pX2vmia2mwnRdXPXqOcW4LQaXYcWWF/GsZwkQgdeoW2pxtT80LvipPgPv
 ZozVFE07xi9efRfWbuLZtvUjP7QAYzEIIntxtdwmT4GmX4eNp3YAwibtVL5cQWdY
 4Fa0KuqW6Goo/+fnaej/lGPRrfbTm7GUUD54+eqb4NhYwKZnc0f2U7ETYlBJq/cJ
 zPqwhf6fzzvZ7AEHP93gNu3jLzle9+NMjJ1i2eaLx79KgYGRiGPw1DWvREQf2mFZ
 SmC1Ru7eOXrt4r+8Ic7kRUL+1XbLw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022105.outbound.protection.outlook.com [40.107.209.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht2d9jjuk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 02:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN2+VYQ+r2nSs8lVF9ne4C1/TDoCetitkn06KhWlUucB+RfK2wzcK2oz88iXIQJY2HgyHZfmAVxLnI2+WDgssQgaNkoUYukwJvJX07gFSS8JLJGR0CKUT+chk4id9A4UIEMvL8F5YaYAB6lMC1gVGv0nEpitgNb7LCqGrWSDQnKE7uikYb0wOv0+OBQaSdumRTBsxg8ur5AP56J7jco0Au/KXewHjr+zwfdcBe/AzITGBrrHoclyCosdaImS7ZIUCKdvckp6PBHpBViUG8nxS7BQNEbwajqL7+sZAyqMzcsce7TK7unHCfukQbG17OKPXmcVcwvhvrs3VfQBXbFOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNjjKSFP3Em4qkV7kA22wx3pE5CmLY4y5IPi2lcNm5E=;
 b=XmcxJQHfjthWQCO2uzPnOnCzFDljCrCMv9WLsges0rO4TGHlXxkRg+93vqTDcv374cPYHQdEb5ZtGUlOlt2YaipNba9YEnuVXMI38frFFbVNdnJJ8ShENs9CoJuRLvX1JziB5UnPw2nLe30RxaW+pDZ0PucxzU+crXWlV+vJCO6yiqVpPQ6kInLBRhRa912TKjrau39NzAxrzYmrx3GsbtnB/xI28oGLmBWUhKunwigrAnK/1RbPNMCXLMcddNA/+DtNrGRMNjRCS650m59fk8Wb4V1ru6Vf1qJmIfxR3I28BG0i9m+MiK/zw0WJ/0pcKpOGin1pihnxuCe+qlQlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNjjKSFP3Em4qkV7kA22wx3pE5CmLY4y5IPi2lcNm5E=;
 b=hwu52xYXhCUm8RUrLqkjsEKd5XPy+9vmVGw9mu0tqjWoDYpmL46vDL+SYjl0FvClONEei7pwfrSbql+i6HrPEpcKb/wjW2302m1l/DgVHzZkh64khUEcSLOe2VKnjuzKZLE6lplbuAE0r7oLCC+V/Xk76i7wMqFzU60+AHSjtwkRjXmW/geUCDWFcmmmNkjD+KDzBRZW2UbAr1t1L9znBj18Ui17Ri6NLZ73N5Pm9CwNiJpL1A69fueF/HcZgcKxh7EmVNXn67KVreWG4VOLxgkZMmhkYZnASKaTEuhiQZbb68GKrYGVRPsTmtHXNPo788FevT9j/mMv+N3BA5Yzyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by AT6PR02MB697480.namprd02.prod.outlook.com (2603:10b6:170:10e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 10:17:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 10:17:34 +0000
Message-ID: <aaba798c-591b-4956-be34-e6c9653398c8@nutanix.com>
Date: Mon, 9 Nov 2026 10:17:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
 <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
Content-Language: en-US
In-Reply-To: <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|AT6PR02MB697480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc11701-08b1-4e2a-525d-08df3e4aabc4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|3023799007|4143699003|261102123227099003|261022075727099003|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jigY0CDTlJLmyIirJkaO9KTkEN24icBSJdmuX/SDn94nFz7Z62v0ugaRpmX01liO1rfQBjgxBmpTz/o6ZBUoZSP77qhif051bwqyOwLbPiXnlLLxQ6ICBKKPSWxgeXuMoeKAoVNyUG5Ti/nDqI+zIluyBsKueWktEFyoNcjFT0Nd5fz4wFD9SxJweehEHesQ3Dq26RHe7/39heulwIw1IBbekrnnjFRDTxqRwH7pOoNH2rO2JV99zZWd6/h9ITv/seCNV2+mgL55Esqzm1zTdNqGtUEPLxi3milt8PjmrPLloIXbYfzP+m7WXMZzv2poH58Nh3uaGiJQJ0N23uXywUyD9Dt7mNoQ4qMyiU18huMvOyrgOhVfCg8YlXknSM7nxknAeu3uJNwk5M6i6Vmb4JkPsp8zbSP5v76DH9c7ml/cektWU1q7+XKcvlpeUeLUdX2KvxCc1UjMIKrhHTCpvjim1pyBZ1bJODHkuWthefYbl+NN2Ywys3pyWNFnCtEcEs59hn5OaJ23inrwdkcvx5AZiWtZI5avfAUbVMj5HKy9yLy+HdYgJKeIfahovvVjqIGPjPJIGGtsu9coxwek8HsJD+/YPfd0iGY2gDYq1YuD03uNAxjMj5K6m+ELBtuCwl6AowIEGWdN+Sv32UnCOeWUquTgHz+6GRO+nH4XybM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFo4WmJJb3E5U1hmZmFQQ1NtNEFIV01ydnVJMUpWa2w0cTFRYXFHOEZXZTdp?=
 =?utf-8?B?ZWxLQVNoVjkyRWVidjl5UTNRSktYdWNnQkNKUUtoUjJwNDBTeWdwZkpiV3RO?=
 =?utf-8?B?TnlZd3NzSGVRQzdJanBlcEJnekZoT29qaloyVm1RYTBhVVdxVG5WRFdHRVJn?=
 =?utf-8?B?ekNBRVpjWVNIK1dRK3BzbWd0YnJ4TFQ5N3RVVGtEOVBtbGdhYUpVWW1iZ1lV?=
 =?utf-8?B?VWFYb0lJZENVYlVpeFRJVno1eGZkRW14SHFQVm9ucmFhQzI1U2VtQXptUDhG?=
 =?utf-8?B?Ym5Qd2Fac2NlU1JLTElRK1QzMXhiWW1Hc0FLekljRE0zelRtN0VwbGt2TTFt?=
 =?utf-8?B?dmYxWEQ4c2lTamVHb0UzWEV1NEpqVHZmK2g5OU96bWN3SVZnN29WTk8vN29z?=
 =?utf-8?B?MGtkSis1aXF5bUhnWjZmZWM2UzNJOGJiUHFhQ0lBOHN6Z3N2bko3cUd4NHRR?=
 =?utf-8?B?cDZXdnVuQU0zSnBEV01WMGwvNVdqWGlpS2UwNFFXS2ducjBaT1o1N1NSdG1m?=
 =?utf-8?B?dXN1UUlPQjNYa3ZDR1JqaEtuNDl3SWwrVjJ0WDJ1MnhwZ1JJR1dkdWEvdGNF?=
 =?utf-8?B?eU93M2d5SXpEWktCeE5FWkYxQ1VsVndSZ3BEMWlHOEMwbTdoQlpYbmtQYkFQ?=
 =?utf-8?B?UjNsdVV4c29KZ0I4d0dyVW9IVzIwemVaN1BWc0MvNkZ0aEtONFNYWDZVcGt2?=
 =?utf-8?B?WEZwMXgzbE1yM2R3Y2x0c2hRZ3kvN3c0UFBxMEYvSldTczNzT2dCWnFJNVRH?=
 =?utf-8?B?VmxaWnJxNkcwRkxZejRiYkRWRU5MQndiQ2xXdHNYSXlkV0VZOVBteG9mSmkv?=
 =?utf-8?B?eUZlK1lNRXQ2ZEVZRlpINEx5blhqT0NkU1hrczhUS29xQUdoQTlRYmhBRkZP?=
 =?utf-8?B?blhUYmVDd0hHdnVISHNzTysxdGMza2JvcVZrVTFYSU1vUnhPVHVtVUJFS3Z0?=
 =?utf-8?B?SkszMTB3MjBLNGNualljZUhsa2FLbFpSTHVsNHNtTVdjaFIyZ1pVQmdwVk81?=
 =?utf-8?B?dEVZczRmWGUrVEZXRlFlK2RnNEZnU1NNdzRUaC9lZzQvWDBGZk9RSFNQa0xl?=
 =?utf-8?B?SjBLV0haSUVXNlMxeTVQQWYzdXdJbFg4aVJZZk1weFFwRWEreFRKb0N4ZkUv?=
 =?utf-8?B?NGFFd0EzY2NCdlg4ems0VXFvS1M5NHdzbGhUU2ZxUzFVUUVRajNGU1MzbVU4?=
 =?utf-8?B?dTY2ZDI5dm1XV0lLQTlHOEd6L3VvQlNQSHJ5bmpRNVAyaDlISHBZYyt2UkRq?=
 =?utf-8?B?UVpvK2xsd05ZajFpcStKSGtxSkZudGE5UUpLN3ROR2gwdUtUam1xVWF5SzBU?=
 =?utf-8?B?RDhOZUlnWjRZYTkrUVhVTDlSUHB3ZWlJaTUxeWxvRDQ0S25wN1JBc2ZQTldM?=
 =?utf-8?B?MVBDMDZlQ3I4TmZkL2l0ejRoa2pxa0J3TGJnc2RZMmRBbC9DRFVZQnVjZHNN?=
 =?utf-8?B?VFpJR0tiKytJeFkvSkJNVEFleUtWRnNsbDJGWDQ3cy92Z0lBQ3l2RjlqVUpu?=
 =?utf-8?B?SDRqSWFiVExJVFVjR2syRmRBZEVEbVJRL29NeTBLdExaTk5WREp4dFBZMW5a?=
 =?utf-8?B?Tlo1Ri9tVEpDckZ4NGRDKzByNWFRbDAxeXRhcTlSZUlwZnVXR1RDTVEwVGNQ?=
 =?utf-8?B?NnpaMzR5OVpjYnV6a0d2YXkxRE90dW5xZXJHTnhabUM0Vnk2ak9JeE8xT2cr?=
 =?utf-8?B?NmJOQllSVUgvRDYrbnEzQU90Mmx3d3VEcHlUeW1sS2NqdnVQeDFLUFIxT05Z?=
 =?utf-8?B?dmcwY0hCelZ1Zmg2TnR0VUJLVGxXdDArTjFFWFkyM052NnFYblU5RkZDVWRp?=
 =?utf-8?B?RmFIeVorYlNzSjQ5NEVPVzFKMSsxeDBjWEZIOGtlcG45ZlI1MFh4OWtSeFZF?=
 =?utf-8?B?cURYRkN4cTN4ZU9kVVpGTEp6eTFnRFRDTXdLc0ZnU3FlNzdEV3hBM3cwYzVB?=
 =?utf-8?B?by9CcFBpU3VLYWJVdFBTdFRiOFF2Wm5oTlJrWU9wSlNmYVM3cGc1OHBUWk9H?=
 =?utf-8?B?ZytGcm56TFphbmU4Q00rTzdYaStNUVg5Y0VqU2ZQcVp3Yzh4VXZ5Q3JXRCtw?=
 =?utf-8?B?UWhhbzFDUEFkU0hlRnU5UUZkbWRjVTlXNExKYjNJQlJ2aG0rZmhwM2xIWVdj?=
 =?utf-8?B?Z01NVkN4M2MxUk9kUGFZNEpSSVErNTZzZm1TSGV2YXBCWWlEeEdwYTREaWxL?=
 =?utf-8?B?UlZWYUxwWVVkQnBNU1U5ZUtYMk9Mc1U4dEdxcHArOFpzaXpobytRUitubURX?=
 =?utf-8?B?K2VHSHFxUE01bmVZU2p2WndxK3IreGRvK3V6dzBUV093bVZkRUwveUUyVUY1?=
 =?utf-8?B?N0ZaSkZFQmVIZ3QzY292dldPZW9ReGlWbVhkNGZ1amI5NU9jdUpvNExpa0du?=
 =?utf-8?Q?xCQQuNQbczMzjK6s=3D?=
X-Exchange-RoutingPolicyChecked: k/WEz+oGHPEDVd/HBoV+4Q2SGZ0PC77qAJsP91W7FUnyxUmQXZrIRiPr6QsguKiBYt9X6uNnV7O6CPzxhFDNAI0ZBvyhxyjYOlDorOkxfLhos8RVJC2HPBdJTruWP4HSzRaLe1d+ePnl74UsRsmyMQGn3gG2PCwxFnSB3iNWYBCrSPwaebdcu6dNrlKC4zU7EAEP7xizS8WRIPLA7lXyK10GhQkptxMKqXh48OFeD41T9YJa6JFdsTUS8/d3dNXqv3EM388Ok2ExR8rkpstphf4sHVJRF8V+ke6G5wHg+Q1ezNcuIep7rONIg8X8Kl6EG5mtd5pJus97N25nwLv9Qg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc11701-08b1-4e2a-525d-08df3e4aabc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:17:34.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxLRfYmZhv5k5KNLhgz8y1ZLNCCyionNE27cCseZ2v0OnWEsxt+pCp6qxEfZo/gKxWPhEk2zIcgrCd+N+lYoyML2iBuo2f3lQZwkYco2sNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR02MB697480
X-Authority-Analysis: v=2.4 cv=U5IHnuru c=1 sm=1 tr=0 ts=6af19dc0 cx=c_pps
 a=5fNYnt3/gC+uMcP5UkWVcQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=20KFwNOVAAAA:8 a=HTweSvWT_fJOxDrsfvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfXyCa0w6Q23rO3
 R0ulQ4nimPlDP6AB6+6UBkFo4zVH9LZG82OjkGIUAU47KkfOYn0h/67KoFDY7UFOLm6rdfbsyT4
 fv6nSmKpGKrIV0y8Bg6AMyP6/MSjQd0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfXx0CSvu4S3mLN
 t8EztYLV0KV3OowxBdSAfgttcOoETFDIsoFO5IW0N/8X8qU5XHKwCcnwd0sZ4GhwNljlMrkTBJs
 MUZ/th2+csqnGpVR2MQPosDEUd++2i3F3Rza4Bop8TOHTRHJgtkVIl4wr5pQeEydh9W5nC7nhF7
 ofbPFqUP5g2n1vj7mjuEyUkHB5RhRWNhZfoh/0O56XGapOO483gRIPHParhZcxfYJngBoxTFebf
 7ftK/0XeRkkj/8t7iL2gkrhvQaH6bzWDdSS6JM4ujFflkSPLriLiw16LIdE5mf8UM5iobWymfXT
 k3In/vaYR9j8bU6+iOWaAzdl6ZF8Vg4JPLDbdZRavFvUXX69JDaI0UpJgmENl4l7erAaoXnRqIS
 gDyZ9TcxVyra++/HsU/M3SrUTrQKaqZ/QtxLZ+X73/KW0PZPH5sF8H/2j/0xYl+zbjO6hpGQYdT
 2MD5fXwr9D5FS+GHFvw==
X-Proofpoint-ORIG-GUID: QGddy3-1VSvad8w9Zx2qiZgLGwead_hO
X-Proofpoint-GUID: QGddy3-1VSvad8w9Zx2qiZgLGwead_hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/11/2026 09:02, Mark Cave-Ayland wrote:

> On 06/11/2026 11:04, Markus Armbruster wrote:
> 
>> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
>> "pca9535" a child of concrete type "pca9555".  This is inconvenient
>> for the next commit.  Make them both children of new abstract type
>> "pca9554-base".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/hw/gpio/pca9554.h |  1 +
>>   hw/gpio/pca9554.c         | 55 +++++++++++++++++++++++----------------
>>   2 files changed, 33 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
>> index 1b33a8a752..0d841ff017 100644
>> --- a/include/hw/gpio/pca9554.h
>> +++ b/include/hw/gpio/pca9554.h
>> @@ -8,6 +8,7 @@
>>   #ifndef PCA9554_H
>>   #define PCA9554_H
>> +#define TYPE_PCA9554_BASE "pca9554-base"
>>   #define TYPE_PCA9554 "pca9554"
>>   #define TYPE_PCA9536 "pca9536"
>> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
>> index caa73f63c9..1362b605c2 100644
>> --- a/hw/gpio/pca9554.c
>> +++ b/hw/gpio/pca9554.c
>> @@ -26,7 +26,7 @@
>>   #define PCA9554_PIN_COUNT 8
>>   #define PCA9536_PIN_COUNT 4
>> -OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
>> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554_BASE)
>>   struct PCA9554State {
>>       /*< private >*/
>> @@ -58,7 +58,7 @@ static const char *pin_state[] = {"low", "high"};
>>   static void pca9554_update_pin_input(PCA9554State *s)
>>   {
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>       int i;
>>       uint8_t config = s->regs[PCA9554_CONFIG];
>>       uint8_t output = s->regs[PCA9554_OUTPUT];
>> @@ -110,7 +110,7 @@ static uint8_t pca9554_read(PCA9554State *s, 
>> uint8_t reg)
>>   static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>>   {
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>       uint8_t pin_mask = (1 << pc->pin_count) - 1;
>>       /* Variants narrower than 8 bits ignore the unimplemented upper 
>> pins. */
>> @@ -134,14 +134,14 @@ static void pca9554_write(PCA9554State *s, 
>> uint8_t reg, uint8_t data)
>>   static uint8_t pca9554_recv(I2CSlave *i2c)
>>   {
>> -    PCA9554State *s = PCA9554(i2c);
>> +    PCA9554State *s = PCA9554_BASE(i2c);
>>       return pca9554_read(s, s->pointer & 0x3);
>>   }
>>   static int pca9554_send(I2CSlave *i2c, uint8_t data)
>>   {
>> -    PCA9554State *s = PCA9554(i2c);
>> +    PCA9554State *s = PCA9554_BASE(i2c);
>>       /* First byte sent by is the register address */
>>       if (s->len == 0) {
>> @@ -156,7 +156,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t data)
>>   static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
>>   {
>> -    PCA9554State *s = PCA9554(i2c);
>> +    PCA9554State *s = PCA9554_BASE(i2c);
>>       s->len = 0;
>>       return 0;
>> @@ -173,7 +173,7 @@ static void pca9554_set_ext_state(PCA9554State *s, 
>> int pin, int level)
>>   static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>>                               void *opaque, Error **errp)
>>   {
>> -    PCA9554State *s = PCA9554(obj);
>> +    PCA9554State *s = PCA9554_BASE(obj);
>>       int pin, rc;
>>       uint8_t state;
>> @@ -182,7 +182,7 @@ static void pca9554_get_pin(Object *obj, Visitor 
>> *v, const char *name,
>>           error_setg(errp, "%s: error reading %s", __func__, name);
>>           return;
>>       }
>> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
>> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>>           error_setg(errp, "%s invalid pin %s", __func__, name);
>>           return;
>>       }
>> @@ -200,7 +200,7 @@ static void pca9554_get_pin(Object *obj, Visitor 
>> *v, const char *name,
>>   static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>>                               void *opaque, Error **errp)
>>   {
>> -    PCA9554State *s = PCA9554(obj);
>> +    PCA9554State *s = PCA9554_BASE(obj);
>>       int pin, rc, val;
>>       uint8_t state, mask;
>>       g_autofree char *state_str = NULL;
>> @@ -213,7 +213,7 @@ static void pca9554_set_pin(Object *obj, Visitor 
>> *v, const char *name,
>>           error_setg(errp, "%s: error reading %s", __func__, name);
>>           return;
>>       }
>> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
>> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>>           error_setg(errp, "%s invalid pin %s", __func__, name);
>>           return;
>>       }
>> @@ -274,8 +274,8 @@ static const VMStateDescription pca9554_vmstate = {
>>   static void pca9554_reset(DeviceState *dev)
>>   {
>> -    PCA9554State *s = PCA9554(dev);
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554State *s = PCA9554_BASE(dev);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>       uint8_t pin_mask = (1 << pc->pin_count) - 1;
>>       s->regs[PCA9554_INPUT] = pin_mask;
>> @@ -292,7 +292,7 @@ static void pca9554_reset(DeviceState *dev)
>>   static void pca9554_initfn(Object *obj)
>>   {
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(obj);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
>>       int pin;
>>       for (pin = 0; pin < pc->pin_count; pin++) {
>> @@ -308,8 +308,8 @@ static void pca9554_initfn(Object *obj)
>>   static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>>   {
>> -    PCA9554State *s = PCA9554(opaque);
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554State *s = PCA9554_BASE(opaque);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>       assert((pin >= 0) && (pin < pc->pin_count));
>>       pca9554_set_ext_state(s, pin, level);
>> @@ -317,8 +317,8 @@ static void pca9554_gpio_in_handler(void *opaque, 
>> int pin, int level)
>>   static void pca9554_realize(DeviceState *dev, Error **errp)
>>   {
>> -    PCA9554State *s = PCA9554(dev);
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554State *s = PCA9554_BASE(dev);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>       if (!s->description) {
>>           s->description = g_strdup(object_get_typename(OBJECT(dev)));
>> @@ -333,11 +333,10 @@ static const Property pca9554_properties[] = {
>>       DEFINE_PROP_BOOL("hw-dir", PCA9554State, hw_dir, false),
>>   };
>> -static void pca9554_class_init(ObjectClass *klass, const void *data)
>> +static void pca9554_base_class_init(ObjectClass *klass, const void 
>> *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>> -    PCA9554Class *pc = PCA9554_CLASS(klass);
>>       k->event = pca9554_event;
>>       k->recv = pca9554_recv;
>> @@ -346,26 +345,36 @@ static void pca9554_class_init(ObjectClass 
>> *klass, const void *data)
>>       device_class_set_legacy_reset(dc, pca9554_reset);
>>       dc->vmsd = &pca9554_vmstate;
>>       device_class_set_props(dc, pca9554_properties);
>> +}
>> +
>> +static void pca9554_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>>       pc->pin_count = PCA9554_PIN_COUNT;
>>   }
>>   static void pca9536_class_init(ObjectClass *klass, const void *data)
>>   {
>> -    PCA9554Class *pc = PCA9554_CLASS(klass);
>> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>>       pc->pin_count = PCA9536_PIN_COUNT;
>>   }
>>   static const TypeInfo pca9554_types[] = {
>>       {
>> -        .name          = TYPE_PCA9554,
>> +        .name          = TYPE_PCA9554_BASE,
>>           .parent        = TYPE_I2C_SLAVE,
>>           .instance_init = pca9554_initfn,
>>           .instance_size = sizeof(PCA9554State),
>> -        .class_init    = pca9554_class_init,
>> +        .class_init    = pca9554_base_class_init,
>>           .class_size    = sizeof(PCA9554Class),
>> -        .abstract      = false,
>> +        .abstract      = true,
>> +    },
>> +    {
>> +        .name          = TYPE_PCA9554,
>> +        .parent        = TYPE_PCA9554_BASE,
>> +        .class_init    = pca9554_class_init,
>>       },
>>       {
>>           .name          = TYPE_PCA9536,
> 
> The basic change looks good to me, however I found it tricky to follow 
> given that PCA9554Class is now related to PCA9554_BASE_CLASS() and 
> PCA9554State is now related to PCA9554_BASE().
> 
> Would it make sense to rename PCA9554Class to PCA9554BaseClass and 
> PCA9554State to PCA9554BaseState here? I think it would help make the 
> hierarchy easier to follow.
Another follow-up question: how is PCA9554BaseState related to 
PCA955xState? The naming suggests that the latter is already assuming 
this role.


ATB,

Mark.


