Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE617606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=JPtbxwL8;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=sfcuV9dm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBbA-0007Nj-GC; Wed, 11 Nov 2026 11:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBb8-0007Md-KS
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:54:58 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBb6-0004EW-Jv
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:54:58 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0MAu3767214; Wed, 11 Nov 2026 08:54:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SV3PkdIcVRFPTIw20u8tIPItPBbY3Zk6IgWlKiME2
 m8=; b=JPtbxwL8c7XWzsDrU+vHrn0wRR4Uj+V0gmToeth7DCcRyFl8TG5T/KNYw
 an34Ks5qOkn172CSANqQ2vlD1k9vYsbtR2VdOGat1RmJl2ycTnPZdA3yAwDqCyRx
 NCpHk9wuPBCtnzPIFFLyhy/BMbh3DifxBdXYK+j3V0zg74G/d+mGH3vZ1ZSZ/Xsr
 u6/YEJ3fV8g089ASDAvVyJ6O/0Zfz3jtQMpwOgqSV8VR/MuEQ1Pj5F9AEouLZV/r
 W0U25aBeSQrSWZUXN59ha2NgSaca4Vat3SlKcqFZU8WQyqEm3gNlY9weF6z8NfSn
 0zLaPM2IQyJ5AcO5GLFH0KX+BsExg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021112.outbound.protection.outlook.com [52.101.57.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hupmrn79b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzPtfKQ0ybe/4scJqtsB7qTyq3KdGkDzzCURHHsaLLo3RhcEEhmUUBDrtu2r9200g5RHMC/VFAvG+ncGUO8hPA4HumDcPgXbawYtdJhLU8hLPAbpNnvscsswiUqpfZ3cRptELq7iknR7+2Z75X2CLk2A7tb7JSuAo0ec3PYmXqJ4Y9MEEk6EEzfWQbYmpDpbpKYKWiIGn690VdO4uYlKkbcMjw/+PwgtTqaQ+abuZ+9k7ts4QX7XWH9sWdKyO6lH9NYPEDE9yM3At0gBALlUlpYZHZlSDm3Sny3/93vyNlu15McPOCrlhxS7bpHg9yJYud69yihlsyvacN6xnSJPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV3PkdIcVRFPTIw20u8tIPItPBbY3Zk6IgWlKiME2m8=;
 b=CpbbUV1WGXXhxHIVbyFPaRJ97NxqyFRXcWc8MOnxO8Bw8OAUVuJADhbkHugR4TwDU3FkEXuhvOje9tLu4Eofb21KAn5muizw7oRiD2euDFd/dU1dhNHgSXRNpKFHLJwHGP6XxPxrYVG1HmfQG5ibSuULHTGhSbUnqFs//0QO4zXKRhKcaVEnfl1kzOBEBKPFcRnWEtfEWOFr4RhOL5UaGQDM1kbMN1ImSzC5CxdE+ZuD6aysmyJ5FG521xd3wYuZHqIXr1edLYNZA8/IKJk0J+sfc26svGVe6pPHoML8adTljouTB65fT85r2K6JD/uTcAn52Tt+C+sDPEq4t6k3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV3PkdIcVRFPTIw20u8tIPItPBbY3Zk6IgWlKiME2m8=;
 b=sfcuV9dmJb5AbMFMC8mPKK3h3vi67F4jzMePT/i0fVcoyBsdIpbh+HZjN0R1HpGxf4d8g9uLekbeHCoQgw8v2rjFfQUiLsfrJa3fNiCq3VJuge8SUpBvDTNuXUysUxlXfexdFrB4ZGp/1oDW4XxA9QR/7nnlruH1BWEeOm2VoaWE+aL69tlnjYYjX9lsF4x2otMqPxMdx2Fu8zbhTDcH/MSPH3ifr79SzbGgl7S1G1hebB8ZTw+qVCC8msBBFYGByDcUMeFH3FKvKhUGaMp5zDLZxiH/JcmavEM9ayy+/cXnyR8oBUy0vwaPFtIb3GWNVuwWI52p/r+oYfd3sgX+7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB7857.namprd02.prod.outlook.com (2603:10b6:208:33c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:54:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:54:49 +0000
Message-ID: <a376ad96-6fec-4014-996a-3d8615c38a2c@nutanix.com>
Date: Wed, 11 Nov 2026 16:54:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] backends/hostmem-memfd: Add huge TLB properties
 unconditionally
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-8-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 809ef404-3534-4421-2fd2-08df40147f65
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: PW/nVZXpvy+FwEA8Szz1J1KT2oyRbXmguvFEmI+HqKUDpnV2tNe71ISzZvkUiM8CnWUVzdriq8A5GIdvI92C2ldj7GUGTXFa38Cv8veuAVyoDkoUdoE2/1c5saUYvpdl6qNTtUg5r4apMLdspJtUYXshyhV2FVbM8vius1vOPdn3qXMjqRCPd2kkeDcsNzf15UzmL/hDJ7d7sDLIL3c77MNK+7tg/iBVPTvDs3LeMr21yTOY3ikNTXAKKqLrjKxrQGaHPc/jGMamhGD2luEUYdYSP+75dJSlafsK+nFvrRsHuHrL+dllPxxOU7HOePja+MvcADFDZZY8wGASougC+wqH0u98D7STKwWmAH4omijw724I7NrgPoBsi3tXHHuBCdH4POWdwoPOmIZBnSKnXGwCSOrGUYHXIuqh0VtymlF/ejYy1DGI79iBBLi3DBj22g7WvHMrnZ2PIlZzS5wqLYM+tXhYMEN5K98SPRCEopIO1YeANcgXYa/mOZm5lAWMGQCGXpsNVTGYwiM0+ofZ2X64XHHQRgXrvcwnfXgpMPiszwCSQaei/Mpc3ZBQw3TFrE9EVcJZXcas209OjLklYCX3iMmD2q4olrRRW+6GEgoIJZPD3assZ6FHomPsnxGxlZhxI6BFOGSG/EonJRkWEftvt9OrnYaxPvuRt4aIqhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUIzT1d0YSt6VE84bDA4ZWwzT0RnOGNQU21TWlBWb1NLckZReVkzdjdIN212?=
 =?utf-8?B?Rml1ODYrWHhCaEhtWVYybVgxQThRWXNZVmVTNlp4Tm1IdldLSHQrRjlnSHRa?=
 =?utf-8?B?YzFMSURuZzBuNzkyMWlKZTBMY0puUGVoYjYydnpjaVhYSm5hMGExQU5uUzRk?=
 =?utf-8?B?UGV4amFQZXFXbzdYYjF2VitxR3Vpbm5wSDRtc0xOZTExM3JGN3M0aE9VK3Ar?=
 =?utf-8?B?cHpqQ0FaZks0eXllU09jWml5NzhCZDZ6ajZmNmpUMFpGeFJsUWlWS2hzKzNZ?=
 =?utf-8?B?R0VIRitJeWxpeG0rcEVMRXMyWksxMVJub05rMzZucVZtaWdCU3FiTkN0aks1?=
 =?utf-8?B?Tys3ZVZsNE8xbXZSaHpkayt1SWM0Yndac2VuekJZNkRLU0RMcXJ4Zy9rZ1l1?=
 =?utf-8?B?dmlEQ0ZFUFEwNGhVbEp0bTNQU0VrSEFRaU9rdnY0UWU2b2VYUXVxcFdxYzJ1?=
 =?utf-8?B?WnhtMVhwalFVNmtkaW9TL1dwQ3dMM1J2N1p0bEZtZmRtR1pSVDEzbkJ6N05R?=
 =?utf-8?B?ZG5Xc242Y0RiN2pvSUxEYnc2VTJvNm5tSU8vWUpLNXkrL2NRaVNTRnN2WUpm?=
 =?utf-8?B?cmYyemRpSGZjQW4rdHUzSFdzQWtuYXdpQWJSbE9pa1NCRFNoQjZJNU1XeXBT?=
 =?utf-8?B?bVRReHZ0clIrNzdxNDFYbzZ6ektWaEcxZHdLVUJkelhrWThFeTJtSmJVWkNO?=
 =?utf-8?B?V2dNbTBaTnVYbTlUdVVxakloRzBwaDgyZnRKc1luYVFDMlpuV0hHNWhQMkpl?=
 =?utf-8?B?MExIeU1COWtUdzJVTnZQYnVWTGNERUdiMVFkN0dUNUJCQ2g2bE44bDlkTnVo?=
 =?utf-8?B?NVMxbGJHZFFoTFl1eTdOZU4vV1pNREg5RXJGWlNCOUprT0s0ejNGQ2daZllw?=
 =?utf-8?B?MkI2MVkzZ09UNnlVVW55OEJuaDdtTE1Uay8rVkp2a2Q5cllOVWZHR2NPSjVw?=
 =?utf-8?B?bTREZTl2cVZZOG41U2lzTmlBUEV0aXBwbTB1YVlIRStQOWwyYjZsWWxSVkEr?=
 =?utf-8?B?RVZZUVF3K2x1eHVpSlFlb2tSdUlYUEFiVlZEVG5OeDhWd0w3ZGwvaTBnajYv?=
 =?utf-8?B?MUszMmU0Mkp0WGtNWmZqR1UzS0dpTE40U1Fwc0Nwak5BTDZmT2RjTzJxdy80?=
 =?utf-8?B?eHRIdzIrcVFMbHVkNEM4SnFyZ3Y1cWtVR01kSUxleHhHVHk1U3BWaWFYbUVm?=
 =?utf-8?B?WE9McjVDVm9ubzBzWXhCRXhicEJ3U0Q4NHZKN2tSMXQvcHpFNU90QUdCa0FZ?=
 =?utf-8?B?dTlLZ2dVSkFNVUVldkd3emh3Q1FwWHFuUk5wQlFHU2RXbE1jTnE4eGFFZWU1?=
 =?utf-8?B?RWxKRVNEVzYzSU1Ha3A5R3NQMkEraDdxV2NqTEt5Z0ozZ0c3T0RjTkJSZnRJ?=
 =?utf-8?B?VWl3QzRoQzA3eHRtUm85aVBPWnE4RkYwbWVEWWV3aXVlS0VNM3dQVWhUNDd3?=
 =?utf-8?B?U1IxZmd6STNRUVBYM3RTR2ZDRWxmYTJkNkJpQ1c3Z2xqQTlyWjJ5OE5iT3pH?=
 =?utf-8?B?bXREV0FObXE5Y2p2UmpGTjJqcXhsNUN0ODRmY1BtMEFVNEZ3Q242YUs3SEc0?=
 =?utf-8?B?SWhHaTF3T3kzRjhsdTZUL21DcjF1RFhuZDl2c0hCcDhmeFZLRnVVNC96cFR2?=
 =?utf-8?B?QTlHSVZybnc2R2FFcUNFbzE2NmdqK2JsOElSUkxyQ1Y4WlNYK25nalZ3NHhT?=
 =?utf-8?B?UWdXc2hjUjVQUVJQVTBWSHhCeUpKQlB6dC9xbWZ5UVIxLy81b0hLMDd3L21U?=
 =?utf-8?B?bHNVdHdMSkNweEM5SXd2bTNCa05jYXNaWUJuR0lWZTJ1bHlmYXZ1MnU2K0JJ?=
 =?utf-8?B?c3p6eUZoVHlyajEzcC9sTzlDQnhaZ0ZYOWZiemZMcWJyNE0zbDdwbWdxWDNt?=
 =?utf-8?B?K01kdHE2SmNKSVluVUlXZG5OeDl1QlBNZ0dHT2pLNVZObnBHSlpWQmlXdUM4?=
 =?utf-8?B?RlNDOE9ITlkxUDRaVHJCVTF6V05SRzZqVlg1akRCNElxdWo5bVQ5RjNvT3V2?=
 =?utf-8?B?QnNoaXFLVnZUVGZFWXBSdHVtYTlrMTlKbHd1OTRBdzhvTjdpem50TnJyUW1j?=
 =?utf-8?B?TWk5U0lVTkhBdk9nbm80MUM0ZWtsYmFrODBnMUpUd09BN1BnNUZkTTh3M2w2?=
 =?utf-8?B?c3FnQWhzQlQzZW1uQUgwM2pNT3dXU3JML3BKVzlyY0orTVVYRFBJRldwUEg2?=
 =?utf-8?B?eGVrMUR5L0ZueGRlNm8vVzVoeS9ETkdydkVaUWI3WVZKRXZYdlBOTUIwWkt5?=
 =?utf-8?B?dkt3VVVOWHJlOXFNL3Ayc09JcE9WZ0Mvd0VnSU9KL1laNVpnNkZxbzZNNnFK?=
 =?utf-8?B?azBZR2hhUWFUaXdWZHZ1VTlPVFhmcUlySzFyZHVXdWpES1VzNGZ5endkQ09W?=
 =?utf-8?Q?AyyMfOdE+LRjQMhk=3D?=
X-Exchange-RoutingPolicyChecked: O/SUSVF6ndiXmUVoD9EuQandQQBhHjbFkg5nyDycmqHRZ+/Hw5NY2p3EYX6rYsS2tLn/82XyAHiGjRZW51OeqR5RecNWxcMptmjV0QmWs6hhV3xeUaBMs+Wfld3r6/+Js8IgVzqHc5T3RjSWHL+cS+e4rjKkRnpVaLu5EyIigZbAu8YsMRzbPCyyma2X2lQ0vdSYWFcGylk+Oevd8dlNfLy/jXdoDx9Z3OYxC1ZnsMrXf/fc2esyiaHaqOkm7ZCNRqi5VuuOouEgkROACEJp9U82U91qo3WOrQ8BqiK5ZMbVdqUYvYzXBtV4TzZKOrJDnIAZPSceHuqGJxQ4pXFjdQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809ef404-3534-4421-2fd2-08df40147f65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:54:49.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFDQZU6mYSYRtnA9jwD9JEIsAd1I24QoYGYhhftmBT8rp3RD6NxvEm6E8BqVYjefmPbD10jFf2oR3UffYjzV1ZCBmQbpd5KGxJyUhcOyhmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7857
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX3fP7SWY9AX4w
 uweatieR0ceM6sOAyKU+5R050jNFXeJwJ0Hkrr/+6Zn9BbXkAn6zT8q0gU0aKGBBGM+hJVQZych
 MTD5LqX/56floC9K9lN0TFdSGPMWXzwAEWVsMOLyuXZzIYCx8Nq7/VS6SCV3AV58qj/4teHMhps
 qhtl1H0EljuqP++GTD31AznOrDo+WF37aSw6LcTJLMAMUrhiTciVptL2ST2UUM6cdmQ73FowJ4k
 VJj7CAfJoObii5DMb6voU+nHmkRvLvBXEYW21+HpjdH7TqNlPiUebUIZ2JhGq/9uAWvxgSP/XP8
 Wj7hIuP2b7Lx31kxfj22/ClPW6m/uC1jb4SmJxl+MN7uCXRZJps5iGv8iL7b/uMgHXyRgU30m6H
 rz5zHGezICmiGAy8W1kf+T6K+8tuKVgITTOz+9X5+NJm/ltVLkdZBATFEVd42wmElUyMSSnndIu
 6dtZTtfFZe8ww0qh9jA==
X-Authority-Analysis: v=2.4 cv=fdU4WEQF c=1 sm=1 tr=0 ts=6af49ddc cx=c_pps
 a=Tfh5kxD+BHZRkXOJdNqs0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=kY0tWP-7SoLX7neiUc4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX8fMJHUE0/n5U
 y3xEGVJ3mFyK0wSvZqZDclbNYGzLM06Sl29DZM8oTLs9DKuSSmVpOmM9uaQb43/lcuwmmmRHWk+
 TNwAsETZr0ewaLXU/GAX5w7etltBB7k=
X-Proofpoint-ORIG-GUID: vuMNWNLr8wwLpcIg0a1-fY9YBZiML5bl
X-Proofpoint-GUID: vuMNWNLr8wwLpcIg0a1-fY9YBZiML5bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:23, Markus Armbruster wrote:

> We add class properties "hugetlb" and "hugetlbsize" only when a test
> of memfd_create() succeeds.  Such conditional registration is unusual
> and can be problematic:
> 
> 1. Management applications use introspection interfaces to find out
> what a certain QEMU can do.  Conditional property addition makes QOM
> introspection results depend on the condition, which generally makes
> them valid only for the process that produced them.  Undesirable.
> 
> 2. For user-creatable objects like "memory-backend-memfd", it also
> makes QAPI introspection unreliable: query-qmp-schema claims the
> properties exist (object-add takes arguments @hugetlb and @hugetlbsize
> when argument @qom-type is "memory-backend-memfd") even when it
> doesn't.
> 
> Conditional registration actually serves no purpose here, because we
> still have to memfd_create() for real when we create the object, and
> need and do handle errors then.
> 
> Moreover, we actually KVM ioctl KVM_CREATE_GUEST_MEMFD instead of
> memfd_create() there when @guest-memfd is on.  If the memfd_create()
> check can fail when the ioctl could still succeed, the condition is
> counter-productive.
> 
> Add the properties unconditionally.
> 
> To test, I hacked the qemu_memfd() call to fail.  The error for
> -object memory-backend-memfd,id=mem0,size=1m,hugetlb=off,hugetlbsize=512,seal=on
> changes from
> 
>      qemu-system-x86_64: Property 'memory-backend-memfd.hugetlbsize' not found
> 
> to
> 
>      qemu-system-x86_64: can't create 'memory-backend-memfd': failed to create memfd with sealing and without huge pages: Invalid argument
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/hostmem-memfd.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 54f84ae331a..b945fc46021 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -184,20 +184,18 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>   
>       bc->alloc = memfd_backend_memory_alloc;
>   
> -    if (qemu_memfd_check(MFD_HUGETLB)) {
> -        object_class_property_add_bool(oc, "hugetlb",
> -                                       memfd_backend_get_hugetlb,
> -                                       memfd_backend_set_hugetlb);
> -        object_class_property_set_description(oc, "hugetlb",
> -                                              "Use huge pages");
> -        object_class_property_add(oc, "hugetlbsize", "uint64",
> -                                  &uint64_type_info,
> -                                  memfd_backend_get_hugetlbsize,
> -                                  memfd_backend_set_hugetlbsize,
> -                                  NULL, NULL);
> -        object_class_property_set_description(oc, "hugetlbsize",
> -                                              "Huge pages size (ex: 2M, 1G)");
> -    }
> +    object_class_property_add_bool(oc, "hugetlb",
> +                                   memfd_backend_get_hugetlb,
> +                                   memfd_backend_set_hugetlb);
> +    object_class_property_set_description(oc, "hugetlb",
> +                                          "Use huge pages");
> +    object_class_property_add(oc, "hugetlbsize", "uint64",
> +                              &uint64_type_info,
> +                              memfd_backend_get_hugetlbsize,
> +                              memfd_backend_set_hugetlbsize,
> +                              NULL, NULL);
> +    object_class_property_set_description(oc, "hugetlbsize",
> +                                          "Huge pages size (ex: 2M, 1G)");
>   
>       object_class_property_add_enum(oc, "guest-memfd", "OnOffAuto",
>                                      &OnOffAuto_type_info,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


