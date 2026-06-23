Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5E3CDB47C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc98c-0007wl-Lo; Tue, 23 Jun 2026 17:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wc98a-0007wc-8Q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:58:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wc98X-00066p-Qx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:58:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NEBlNR079444; Tue, 23 Jun 2026 21:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3nTCVjANg5/Xj5uMuNF88lN2ruxpOKm9YzIUE6666tQ=; b=
 cBdMUn8qzP947Jg9dMNPTjV4WsKbvGOuuf8728jYphu3AGdKA8OB6owoWw98pF0P
 UrtYBK4ThgYwB/zZyiT1v4swl748qYhPPa+4IMhaQYJTHSKZ+z961ULcHjkZS7SK
 1To2tmoA8XMvYn6mqv+VgZOS5lMgPl1i3kXsJd1E6f1gNAcqLcaSdqr2JVSTCCLJ
 RWgxMSvnRQAf/iStTq+cBvM3uqJy0TTpSNrOV5iKO+jEykzWhLbhWcQrIdnNFqEF
 rnD6YoQ7hN6Mvj1ce47FSO77Yccqaz3nE1q1r2y42ZWCa7EuXwgsX0R4PYKL/E62
 CCu2qhAn7nkDXP2/IzxlWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1mkw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 21:58:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65NLwJ5f025942; Tue, 23 Jun 2026 21:58:23 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhacmeuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 21:58:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whIlNBiUiLrPqaOyubgk+qfrL+mdWWoCxJ3cS5i++7yYJTOkziyT39MvgLBHveksXrArGnWOgT6jWYmo+ZazNNSIVa9Y9uN2XRz47k/7l0BWYZmF3FwCDNSlJ99f6lEE60jn1UIy472pTOCZnH0dI2PHZcMYTNYmzq6heEHCh2k9W8fvYdI2QrPFxfThVP+6YeqDsTRisqZxMeofHUkQta9+TLFweo88ms5KLOYxTG6+CIrovm0NrYTaO5eXHMfOPL3+2iMT5iQPBC1c12v7iVwawrKgJIO49XCfXVit4IM7CtyC2jGTnXPaVIZwi0mAIRvYgJGSW3AyCLWAbPJaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nTCVjANg5/Xj5uMuNF88lN2ruxpOKm9YzIUE6666tQ=;
 b=Gwg4mP4soAzjiOStdbxnEei+5+05qEdkfReiL9353tpw2a9DDi4n5q87NI/l6NGoZ4/iPMjdRChq6LwSYKS9D/8n7sn9LNWC/braSyF96Vx7pO4ekbzM+lIZJyug89nMyLebCSsUIqNML6tNxWk73NFqg5Dut/0ExLV2Kfph+qjny8p4Mqus7WKJGdjsKnYIWDw/BNWxzPv91oe9BFCM8N1B6i1q1MuY0cJDR7BxRstdp8XTTkqJylbn5Ixd/bv0CFZ2DRW/F+5rOEwMCAhUyt13t0qZU9iDxlA4A6zAgc4THXVFovhnI55jFL7sDHy2erQ3nlwoObC9UzO0HEyZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nTCVjANg5/Xj5uMuNF88lN2ruxpOKm9YzIUE6666tQ=;
 b=a0o4WlYbF3lLlqBXMZj4Jy2KnOThwyekYCbINPi0UfpOTwus+91a5d9LRQa0orIuKNxV7KR3eQBl+9HLj+w2rU2YjEfm3ps5d15tcBylowtswD9X/Jk9PEfwsmZlZMrFn8lESUa569WoDQyBKAtrUuSvdOhXIqT53hF9d+s4wqU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by LV3PR10MB7723.namprd10.prod.outlook.com (2603:10b6:408:1b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 21:57:41 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 21:57:41 +0000
Message-ID: <b4637fdb-c32a-4ca1-9348-3757ef93ea3e@oracle.com>
Date: Tue, 23 Jun 2026 17:57:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amd_iommu: Fully initialize XT interrupt message state
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
 <20260623005813.984238-3-alejandro.j.jimenez@oracle.com>
 <CAFEAcA8NKB6Wg-Gsbv_NXp72PLADS=h7p7KyLCW1gRCbywESfQ@mail.gmail.com>
 <20260623143614-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260623143614-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:610:4c::35) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|LV3PR10MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a6f309-7dc6-4234-5bea-08ded172728b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZK8KJ5dWQxB7l4qIhkIOhVw9wX2sVMoJWm4rgJ2buIE4RMisckt6mqpVkLX6lxyFxgNRTMWs0eP7lUo6OlIyVoVD5AiJUMMyUwSturqJJwA6qxdDWh6OZzqXTBiEyoO4I/ix5hJViuDxtXtSQHuH6AM1uyQRya7zgWt6FeBvFI6y3P7tganHpRYeOQ/fxUM0yidVg4UrFHfbStDRE+toQBbPtIE3ZrB5RhfgAu1JHhqB52dg+7ya5HRc+zjLrW5Lhc59G6FGFR5nyux77oLIIqoG0giqKGQ4sQpjpIbJOpZDRfmRhi9y9+fchbSiQ0s8PimwLacuhASFdza4CORLnL5TD2Ue3RB6ARM+shR2Q32sxSnrSwO0DmCpxKaiwQP4N7KUwmQ/82xV/AcpjUPZoe7Z54aLlJC5SIIEAasmgb5pSjjftnFpG5sYmSqUHj2u9CzfFY1/a3jWf+o9VeBS6Oi7axDaqk5XLnsaYrLE80bDpU/jsRRTAcIBHl8aY9cF6dh498Y3XI0xU8nB0XNynAw+8+DhDaY7gL+y9UUA6XYZsyQCSRvkLLaSfMnmH/52l+yDGg7dapS7Q/TS5b5oLbJrkgy2wz7zXbS0umtmgrXdxLqzYoFaJdoVSSrcZepSvvST7owUyZhoKKHoLDcKm4yVYZsdxh3m21ictut7rVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFlwL3ZhaGNWUm04ekd0RUFrTGZEcmtRcDNKY0YxWnpFb2NuVDd0QTZiL0Yv?=
 =?utf-8?B?NEJSbW1PUWxJcnRlTFFlTytFL05TNUViazYxTFFjbU9wQVJhcVpnTXl6eTNV?=
 =?utf-8?B?aVBRZ2RsYk1oZ09XREZrMEp5ZElKTDlHV2VRcHNPbm8vSmtXZGZnemh5UG9Q?=
 =?utf-8?B?a3ZpRUZkNmZZUmhpTEFmZGUxa1UyQ1h0bUdCM3hDTUxYSkNxZnp3d2hjaWVl?=
 =?utf-8?B?WGIwZTBmQkY1RVFJbGNjUHFkVUJiZW9xbjJUcW8xa1QrR2Z1Qm5kSVc0QzU3?=
 =?utf-8?B?RElLb0dLQkhWWUlwSlE5M3VTU2x1RHVMTzBwY29XMTZtWTFFRERJSTJXUnNY?=
 =?utf-8?B?VzlndktlZC9XOVRlZ3JyRXpKYUdwMS9lSlBpYmJOVXBBaVJtc0dvZUVYelpD?=
 =?utf-8?B?OGthNHQ2ZVhSRGtnMi92bHNDRU1iVzdld1pNVzhmc2FxVy90MVoyNHZHTU8v?=
 =?utf-8?B?RkZQNzA5a0RMSHJMUHVjSWIrVUoxSzUxaXpBTk0xS0kxOUxVQ0xneGpRc0kz?=
 =?utf-8?B?em5CczNOb2RJT0NDbnp6S2ZlMGl0dkRPRGsxVHIrU0haeUpuM2VYRi9VMys4?=
 =?utf-8?B?b1pnSTBKd0xhelZRaVdxR1YrQU1vWHQyMHd3RGh0Zjd6ZTlnMzJIdEcyK09I?=
 =?utf-8?B?K3lCbWNkY0V4VmdiYVJMeW9xYVNXRzkyaXIydmJ6eGgwN3ZVR0puVG03WUh4?=
 =?utf-8?B?WVp2NFRoZzlCZmFQdWJPZVN3QU1ZOE9sTEs3MUxxMUNFTjhWQkQxRUlKS3Vv?=
 =?utf-8?B?QkF6eHdxQjdtYTRaUFd0dW1EcWI2SGRSdXMxSXdVTmkyL3JCcDh0V1BpQjcr?=
 =?utf-8?B?UG9XRnZTVlkrVk5jUFpVc1o5MzJwVGgwbDVkeHQyNEhtMW5uZjJTbExqc3pJ?=
 =?utf-8?B?U3ZIOVZjL21UVU9pWjNxQ08xWlkwZ202eGpPT00vVGU5OUVxWFlsaDM1cU9w?=
 =?utf-8?B?ZjRTYjlJYm10NFNGVU9PL25JU0NhYzM5SWlGMUdDTVFDZTJ4SDNaYTUrSmVp?=
 =?utf-8?B?QitCMVBGY1l1NG13VzB3NWJwQkhuWnNieGNFcVZuQ1BZaSs5K1hsQVREL0pa?=
 =?utf-8?B?aTdwSHViN25TV0ZzUk5UaTFYYzFIR05QZngyOFdVV2trNWpxRHlMc2hxNXAw?=
 =?utf-8?B?NFJXZ1VVYysrWWc3SFhNVEFncGlOWXJBVDVnUjVjaE9HYUQwcGp2d1pFUmNy?=
 =?utf-8?B?RHJmdHIzQjFCVklDRkpYZ3VEMkJEWS9LTzFFWXlvSXI2WENJSlBUbjE5cGYv?=
 =?utf-8?B?eDdvTVl3eEFsRzhSaS9Ld1M0VFRtYTlqeHA2ay81cG9aSVZBb3hFcnZLeHRX?=
 =?utf-8?B?VHlhamttVW1SR0RCanY4YUwyOTBTQWMzZktleSt6dzFuK1BqNnFXKzhBMVZB?=
 =?utf-8?B?bzY4SFI0ekQzV2VCaFl3bjJ5UkVkclFuT2Y5Zmw1OWZ1d1VJbjZscGYyVUJp?=
 =?utf-8?B?eDJ3MWxENzlmYjZ1OUxmbUZoekRGMi91djFlWTJiNGNqSkMxL3hpVDF2aXRo?=
 =?utf-8?B?SzA1Z3hZUGw5WmJ2VU0vMkxpZ2I5VjFuQ0IyemRCdXpjaXFMMWJEUk8xS1Zr?=
 =?utf-8?B?MUhvb3VGYmtyTVIwL0lrRnhERm9qLzBydnd6Q3JQaUpJMUY5TXp3VTM1TzBH?=
 =?utf-8?B?eEw4YnVxOWVRL3hsUGt0MWl0aDBqN1lyaVEzYUJyUkxoaTBPK0ZwTlZEcTlR?=
 =?utf-8?B?c05EamR4ZFVlb3VncU4zeHRZMTJyNWwyaC9Qb0tUbXZvbko1NHgvVVUxdkN0?=
 =?utf-8?B?WmV3U3FPeGxBNm90ZTI2MnZ2U2h1NjFId05QbEQzaGdKeVU0a2VvVVVuU1lK?=
 =?utf-8?B?UVArVWVRLzBKTVlWbVZkMFFMQVBrM1Fwa1VGVHUxbDBPZXhiWDlhRzB0WWlB?=
 =?utf-8?B?SngreXJ1L3ppd0l6T0QvLzE1ZW1xOVJDakZrWDkyUW4rRXR3S2d5S0Z2Q1Vr?=
 =?utf-8?B?eTVQd2lQZ3p4cGhpRUwybzBwWldpNWF1QjZqQWRCcUlLNXJpcmVLdXErcDRI?=
 =?utf-8?B?dklmdWxibGltYndKMjMxdFQ0aFp5NThhM0VqZE9yamsxWWhHVUhJODVtcmoy?=
 =?utf-8?B?WHQ4aDA5Vksxd29USnVnTERvc0ZDNUpQcmUxVGJweXZlSFBvaFBLTDZuVEI4?=
 =?utf-8?B?UnpLNWZUdmswb2UyZWVJYkJWaytXUlJ3WEZZUTVuQk95aHNpYmlZM3JuSnph?=
 =?utf-8?B?VFBDbW96bkxETm5oWnR1VG5HMEhyTG1xeEc2Q3VLUGFtLzZ6MktSdHZiam1C?=
 =?utf-8?B?STc4QTdaOXQrZ3NIQ2JJQnRsbk8rMW1DSzdEckg2c1hlck5WZU8xSGR6eVI4?=
 =?utf-8?B?WFFoNlVBK3AraWpGRkxxWElzdC9rNnZyTkhCSVZaK0pUQy9MQVYwYkdZVzN4?=
 =?utf-8?Q?pckdA9iPgWUPSwts=3D?=
X-Exchange-RoutingPolicyChecked: griu6XFJIxR0jaluotggclVkGJJK0wmalco1caLDuVfDAHIhQNo6QwESnzm17S/0Dlpn/H1pCRDexoc55cVCS5ys5Sm2avt1TDanneZd961krQGCdZh48EPPbReWvtuW6h7Kq/+Ce0H0yq+eJoUwTyLZ+ZL5aPQ5ux4Ok92jMNSmPRYFMiUM8/HdpEfRCrAjOzCjg9l9wCeJwH+ZGSC93X+VUo238G4eXfx9mKuNEvrk6P/i1E2ne5H+dszxX091joBaGNYYEJBUKn4Jo1eTpeeRiJhVaFZLOb7jQEkvqoWJ2KBfPITDpJalIJtuXuvyfC2CUzfjXAgTzXyvKL8ZsA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ogcih1OPFVxLqomu1IQfp9h9+cZBAGu1ZoPetJhGKnGbGXviOLcoy6P8WK0GQvcCImtsT7vy6c/1ANZQiTugH6Eao7dgHamzdBs6eqFm8uyrrtetBVyXOVSnmFKzP/FQZZ8HSvC+06+3ljemKFQU7rbo63+xwFE8Vkpkq5ctXoJyoiUYDKjDamhC9eZg44Bn+Ertn7a6z8G8TBNpS8t3RHa5rGQUdkJznVBKu7mGpdFYWxVsmtzriM6ggaGIOIdve2h9cc84oHVSWT9Zm/5MjEL5vtDwGbCJKmAGezWJF0PDeYdj+RLd7b8D9W3yaX9MkQpw8VelV6Pyc/+0Kvy3qAzR9IarcwAYQwB9UemYLLD4fLq8x1oLvkmV+V1ibmyPW2PVkYKl2hZrTRgG0meJvZxmi0owaiTFejoN4pze/4xYP8Mt2SIFWs4ockmCt3ObXC4fdvYs3OI+ElotvQE4qRJ6smlX6+tjr5JsF1VODvSE0+9P2uHVPFFd/LqYjnGvL6r6JozPiaSk8caYCqTsQMaWgfE3txgPC5xWJLfzAL8klz8qWuCtKIYfNkcTnvWlj0Db/xxfqc14Js3z1rGLuFMPljZmgArvgu+cF/Ymb9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a6f309-7dc6-4234-5bea-08ded172728b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 21:57:41.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLxP23XBESqlpgJGR/qd9ealTS/BVu5mqtVWuiu9aR3J3xFs3GFsP6WsSV2wZmUzhI1oWxUtbiDOzIUnbIz/JcE0OF0L9PzyKDk8fulQmJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606230181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE4MCBTYWx0ZWRfX32JGSd4YGUsS
 g2TWSxv/6CsRzptIroCTWbXzR63506klGXCAvTA/oLmEREH1WhmurMJJJRWY6RGS6DN461RyTC+
 iFNK6WbEX39URUjrbweNkB5OA0HyG5QqVCC9sGr5t9/enCICxJhkXwO8enPT/0zAiGHDQUISFKw
 07PI3nLNGwqsf4dfeCBDB+TSPDGQCHVG/bG8IMBiDy+yreo3AzpTBY3lOP9/YeXRKVZNu5Ix13x
 Y21mrp7LgjDxh1NoLMs9wHonzS6U9TvuH3lYf9xLA9P7MpCy6p3X4HZ1HHiltChUpCDmJrRWYD1
 a91XabBVAPazjdnIWZY+Rs5q69nwZ0qNrrk1p/ZGEbvNaL3cMIhKcANxwR8oCSpUyif7sL/J7e8
 JxYcvpVdHcYda8IkXKGXWba3funxhREpfsAc0LSmjvcpWbdAs6o1WYzKM3WJzDpN4zQidd6gnl2
 8lYOWwLB+XYca/jdI4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE4MCBTYWx0ZWRfX3sK/iU8lMhyG
 AWjYHtlKPYtzsTLehWfagi/95WVwEJkOpzcDhAQxUXRqdnGhOXrl3B5VGjPxyJOgU4jZt/jMnMN
 UrUjDDCdfsmH7ynBQ09CYRHOUhlePFFNwY9aP60PjEJAm+lkcAeH
X-Proofpoint-ORIG-GUID: DElZzp5SkynhsljLzyVpNR1K2uipS1BB
X-Proofpoint-GUID: DElZzp5SkynhsljLzyVpNR1K2uipS1BB
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a3b017f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=KKAkSRfTAAAA:8 a=BSpzRPOoaSFqzjSuwjsA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/23/26 2:37 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 23, 2026 at 09:44:10AM +0100, Peter Maydell wrote:
>> On Tue, 23 Jun 2026 at 01:58, Alejandro Jimenez
>> <alejandro.j.jimenez@oracle.com> wrote:
>>>
>>> When IOMMU x2APIC interrupts generation (IntCapXTEn) is enabled,
>>> amdvi_build_xt_msi_msg() builds an MSI message using the relevant values in
>>> the XT IOMMU General Interrupt Control Register.
>>>
>>> Initialize the local X86IOMMUIrq structure with zero for all fields. This
>>> ensures that X86IOMMUIrq fields not set in the XT register (e.g.
>>> msi_addr_last_bits) are initialized before x86_iommu_irq_to_msi_message()
>>> consumes them.
>>>
>>> Remove the redundant 'struct' keyword in X86IOMMUIrq irq declaration.
>>>
>>> CID: 1660056
>>> Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>  hw/i386/amd_iommu.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 0d273fd33d..9005dc7aab 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -195,7 +195,7 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
>>>  static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
>>>  {
>>>      union mmio_xt_intr xt_reg;
>>> -    struct X86IOMMUIrq irq;
>>> +    X86IOMMUIrq irq = { 0 };
> 
> Why don't we just initialize everything at the declaration site?
> 
> union mmio_xt_intr xt_reg = { .val = ... };
> X86IOMMUIrq irq = { .... };
> 

The above makes sense, but this commit is essentially moot because my
follow up getting rid of the bitfield usage overrides the whole thing. i.e.
an upcoming change in v2 will do:

 static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
 {
-    union mmio_xt_intr xt_reg;
-    X86IOMMUIrq irq = { 0 };
+    uint64_t xt_reg = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);

-    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
-
-    irq.vector = xt_reg.vector;
-    irq.delivery_mode = xt_reg.delivery_mode;
-    irq.dest_mode = xt_reg.destination_mode;
-    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
-    irq.trigger_mode = 0;
-    irq.redir_hint = 0;
+    X86IOMMUIrq irq = {
+        .vector = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, VECTOR),
+        .delivery_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DELIVERY_MODE),
+        .dest_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_MODE),
+        .dest = (FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_HI) << 24) |
+                 FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_LO),
+        .trigger_mode = 0,
+        .redir_hint = 0,
+    };

which is in line with your request.

The one reason I would think to keep this current commit is that it is
intended to close the Coverity issue (CID: 1660056). But I can always just
add that trailer to the new patch that does all of the bitfield removal
work, it would just be "less focused".

I am ready to send a v2 for this series that keeps the current two patches
and adds 2 more removing all of the bitfield usage. Or I can just drop this
current patch since it is folded into one of the new ones, and put the CID
trailer on it.

Please let me know what is the preferred way to handle it.

>> This is fine for the Coverity problem, but you do also need to
>> get rid of the bitfield-union as a separate issue.
> 
> Ideal task for AI actually.
> 

Yeah, it is pretty mechanical, but IIUC we are still not officially allowed
to use it :).

Alejandro

>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> thanks
>> -- PMM
> 
> 


