Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062FBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Jde-0000Sz-Qp; Thu, 02 Oct 2025 09:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4Jda-0000Qr-Nm
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:46:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4JdL-0000Xm-5v
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:46:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DMxKd003237;
 Thu, 2 Oct 2025 13:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=XJl30LACRuI13C3Wrm4wBoIOJODw6vXFI+oKsrWdIDA=; b=
 hPOJpery+TnWR6r77wlG/xTFac+o069f17tMiJ97mg1MO22FB9LbkY35Yuam0lNF
 JGp4+BgIxrE/+KhIPZtkgy2pfzilSwr6ZObtXUpn51p0iwUd2g1DvZBqJBpnFoXM
 Cyh4N2qvlKdCLkAj56LZf40EN0Fb973bMWpJ27BX1oISmi4VQD5nWABtBBcD+1HA
 OcZ2DevYlK2+r/r5fyT9xnnjKa9OyazUmMUh+UUFxqz8ugvq9yCcAcDXEHmtqyi/
 9zuftG7DboDt+xakPtH0Zfmz1v/c/S7iAcxQsCsaGC5QIuNoiqftPn5SUuemnjd7
 EwdkhyV5lIF7DAdqs2sEpQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmf1u9xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Oct 2025 13:46:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 592BkLZJ023287; Thu, 2 Oct 2025 13:46:02 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6cbd9kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Oct 2025 13:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cbl+dyAZs+foo/iGyFuFbDdRiRHbbv5+6PEsxvF06v4sGgBb9WnpP+aGgKTNoe6d8OJamV+n5RhJyHsOzVCajjYR16tHVrpAwCv0bh7T9wJX0UnjLGYypfLYBITKWyyNDagIB8jZhVxQEALKOtWkmRMR6SMb/7ZCoGRgcDfUgxCYYfqsDg1xXwvt0Zytdudy7wAOxjPIWp3KSaISaPvzHKPo7CvZanOgqtFphx/vpFNw0VKIdtARI/KxEpfn8PSj1w8/JGR9AdnQj9htI7DI812G/liD3KKJHvNXyzSU53yj04BG7G00SU0guMvcm3Z+GVgKVjKtMjWTwpMCxK0vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJl30LACRuI13C3Wrm4wBoIOJODw6vXFI+oKsrWdIDA=;
 b=mXsgzrbX6Da2uN3Ij8bzB8xwWchkdhF0lasnbIVpIK5dyvidb4YDhX1GxU9R9r35frQ88Dbo9Gv0eOEq2eMtzFMrd/14GSuBeFAUWQ8487mnqQHIPglK7gjGYgJZb7PbFoQUhAPIotsCk4Cm9sMOrPDj6jBYvO2dayeGO13v4soFsuFBVa4PPq4Y2+6lroSJEP5jJTmplB+dIBEBWPSuLvLYDzWyhl7Gpby4y1H8U0jK3iH1hppoXjoyVycoI9/V0gK3IomQscY825G5gUUWQC0ZHQIxi9cxpoj8JLFtz9gc5QRDhf0Ge79/6L8X3UsOApX+ekmxpEStP4TCmAnVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJl30LACRuI13C3Wrm4wBoIOJODw6vXFI+oKsrWdIDA=;
 b=N1akZOehr0pc168RJ2SxB7+49cRNI+Gn04wj7NWKkL6+27I2bF71g23RXiFKZWoSVa7JKgzsXeoPfoL776hmK/RaSl5w/BaBVhrIqvRRFpKvmoYsOsbLR+VO2hstZuG91iTp0GMOo+2JGn7vaunGK+pZg0IczwWf2sj4zdWnZrg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7737.namprd10.prod.outlook.com (2603:10b6:806:3a7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:45:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 13:45:58 +0000
Message-ID: <97563950-402f-47db-97e1-05bd06523f1d@oracle.com>
Date: Thu, 2 Oct 2025 09:45:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <aN2JE0D44AdV-qK5@x1.local> <b40b6df8-9f7b-4ec0-ae59-0ff15b913a02@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <b40b6df8-9f7b-4ec0-ae59-0ff15b913a02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH2PEPF00003847.namprd17.prod.outlook.com
 (2603:10b6:518:1::64) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8759ad-3e0e-4721-5b92-08de01ba042f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjNtSjV4UzVWWGhMV2k1Z2dtOUtNVDdUUFFkcWtERHlhM0QyVFppMXhEcDZW?=
 =?utf-8?B?czNWT0NkWEVTcGtBRUY2eERBdlptaHlHalhTUXZENHY2U3FwTEo4cG9DTk9s?=
 =?utf-8?B?UW5Rb3RpRkg2N3dQbkVLU09nOENVZC83RU8xVnM2RWVjZ0djc3pkdncxUzAy?=
 =?utf-8?B?L2MzSDlMNEhXK1JXejdKZVN0OVZFVXNhOGlKYmFlb2xoOElSS2VacCtsQVBP?=
 =?utf-8?B?ZEg5MWV2MkpLNkQybVhKZFBwMkRZTUxQMDJKOG9mSUFGa0RicVFzZW14dkls?=
 =?utf-8?B?NC9IZ2tJSFVucU1XSU10T1Y5VkVkTCtmekg1OVNFUG5taW5iUzNsM1FHV0NB?=
 =?utf-8?B?TkVHTFpCRVFrUGpTMGlXU3pGc1FTYVhkaTVZUzhoVWZUM0VnSFNiVGFKbDIz?=
 =?utf-8?B?ZnBrUzFtM1JmWEZuTVFqYy90NW9FT2xiMUpwZERRdi9vVnlRam9OSUJ4SGZ6?=
 =?utf-8?B?Y3lBM1hLVmpqY1IyK3FDaEx3QU5ZcGFrb2dPYnd3QWs5bVBpTnJuY3ZPMjk4?=
 =?utf-8?B?Yk1xQTFZWGhmYkdvL1BRcS9RTXBlaG9RM0l1M21WVFlLWmhrMTBZbTlBdktm?=
 =?utf-8?B?QTJIVU5ibFBlVlZEczdzY3RGVVJBM3RVWi9JZTBKQk1HTmdkQ3hOemxZeTJC?=
 =?utf-8?B?S3lNZExGVU5iRm9qR3lYSGlYL2hadVRWaWhEYUxVVVpORnI0bDJLVUhndTN3?=
 =?utf-8?B?c2hBaEIxWXMyMFF6RXd2aHVTN1N0dHpreW94NUpPZWd5REcyU2lZYkhzKzdj?=
 =?utf-8?B?OHRqK2s5L3o5VXd4emFFbGlHZGo3TTQ5STNWWkN4MkoxQTRkbVZYMlUvUTBE?=
 =?utf-8?B?WVB3N1ZsY2dHdnZQcnZobG1vbjR5cDUvRG9BOUxhd0xPS2l1Wlh1M1FvQnpH?=
 =?utf-8?B?c2FkbVVVbnJNWEJSSm80eUkvL3Y3bFFXYWNMd1hQQ1lHcnhwSXRnaUNMWWxt?=
 =?utf-8?B?SEVEcDF2NFZPY3ZoTEt0b2tOZUVmQnVSOHdZcWJVa0FkTDA3TFZlMXJuMkdX?=
 =?utf-8?B?L2tTU2NqcFp5ZnVpQ3g4Zno5czZKamQvS3ZlWG5ZcU1xU3p4TUxuQlFKdENo?=
 =?utf-8?B?UkNwQ3djSHdpMm9qZDZKWlNoejdUK3NsVFVwRzJMeWh5K0JrbUZzNjU3Tngz?=
 =?utf-8?B?OXQrOUVndGZEOTlKUmNoSTkxSUFsNlIyMnQ3em52aFNlSlJuSVZmeWEwWitZ?=
 =?utf-8?B?OXpMNFhPMlhSQnRVV2x1cVhJb25jaE42QldLTEZtWldrTXR1U1lQMWcyaDdk?=
 =?utf-8?B?c3NDL2UyRktJNFc5UWpLalo2N3FGUm9QdEtoNjhFNk5qTVZ6VGZHcGRqUDF2?=
 =?utf-8?B?L2xHY0MxMTBpbTJoMEIzTDNOTGJKdzlEbXFkenlHSmZwU2hweVdHS29xd1Q2?=
 =?utf-8?B?a1ZkL1hlNzBIVWY5eGMvREFYYkhRMDhNb21yY0NGNWlKck16RnNqR0c4blNL?=
 =?utf-8?B?YkpLMGt5RVpKblhCR3QvU0JsM0VEcTIxTko4WjF4QmxUZ3dZOElqZW5meEtq?=
 =?utf-8?B?T1c0RzJlNVo4TDNrOVNOTFVGNlVZMzZoSkxWekFIOFJCZW9HZSsyVHdOL2JK?=
 =?utf-8?B?VWVzTTEwS1cwY3ptdFZQSUZINDNiUnVOYjJmU09UN1U5ekRTQWlSbjd3UC9k?=
 =?utf-8?B?cFdCODRkY2VVOGtNbVZJcWtIZTE3ZFlwVHJHZGVmc3hoZ1NIazFhSkt6WVpJ?=
 =?utf-8?B?RW9xNWd1VWp2M2kwdzhBRjRKQXd1b0NHNU5OelB4N2ZSQ05MSHpaZDVVYmxv?=
 =?utf-8?B?cWh2M3l1ZXpkV2lINklTN0F0OUdodHZsREhSd1ZuY1hLWktqWTh4TWxjNVRB?=
 =?utf-8?B?Ri9zajBtbHozMldsc2dISEZEOHA0dC85d3I1d09zY09Sbmp3dVFJM2N1aENm?=
 =?utf-8?B?M2xYWEZVOSsrbEFLWXkyeXdDeVI3SThwUld1anc1UUVFbEN3VFB4ZGVnSnpB?=
 =?utf-8?B?R25FZmtPeTVFODE0WHo4VDhhQTB1aUhCdC81YkZYT2ovcmY3T1I1ZTEydEFL?=
 =?utf-8?B?dVZrSjlkWDJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnUwTHZjOWppVGZwUGtJZG5kTDhlVHZoY0UxSXExcy9KWXAwcmFSbEtaMGx3?=
 =?utf-8?B?SmFuQUZkRlcrRkpld05jOC82dkpKUDMwVmhLbmMzdUU5b2huZElBdjdQNHFt?=
 =?utf-8?B?SGd2MjgxSXlQVWFBTFdVMjFKc1JWR1BGUnp0MkZqSFNyTkZycDViRzkzbjdL?=
 =?utf-8?B?NFBHekZkUk1EMEJ0MDBtaDk2ZnFwamVheXFlbWQ3MXQ2aCs2UEN6MUY3TFNL?=
 =?utf-8?B?eGpXdnBNUjNDVDcvenEzUFVsQ3hFYzFwQk5tNWdjU2tEMzBLeWhIanlObFQz?=
 =?utf-8?B?QThJc2JJVFJkRXhucHphci80aFk5UlJCWHBMNXhHb0R1SjArR1I3SFpOUHRm?=
 =?utf-8?B?OGFWYTN3R2dPZjNjZlNNN0ZsUmUzcTYrNVp0YXdQVjJObGhVWGo5aXUzTE8x?=
 =?utf-8?B?MzRESmtPaXZBWjdKSHFPVElBbmFtVzZJZWp5VjQ5Rzh4NVp6N3NLV1BJRXBu?=
 =?utf-8?B?SERELy9iOFBUeXhpYVc2MW5id0tzWVV6eE0zK2RhcWlvSmlSODBPQ1RJVWtr?=
 =?utf-8?B?NHZ0WXNBejdoQXQ2N0c2LzJDQkc4dC9qWXhFWFdJSHlhNFJqRENpeS9xNFV1?=
 =?utf-8?B?bVRLR2o0TVd1c25jM09Idk9Da0VpUEdqSjNTemdrZUNXNDVvMGpacnNuN1Fu?=
 =?utf-8?B?MG1JUVNUbTBLRkwvNkpvbzZsd1hzRlI3S2F2ZDlRYldDZGRIemNMTlhmVWx2?=
 =?utf-8?B?ZHUrU1VxM096ZFZrVHNMWmlCS2dXSGhQTTZyeE5GbHYrL1lEVG9OR2FtdUNU?=
 =?utf-8?B?dzh6cXZ6aTdYYUc1WUNQOVFuQjVUeFRJTmd2Lzl0Rit0cGs2NkJNbVliOC9L?=
 =?utf-8?B?YTVnSm5BbDFkdWRzUlVUZ0lHczUrRG1ZM1BJa3dzVG02QmhXODNaZEU2Q2Fh?=
 =?utf-8?B?aVNDZFhFQlJzUFZQRXRWYXVUZklyNktoMjJlVHluNVZLZ2VVSllUK3NsUmgz?=
 =?utf-8?B?S0NjUWkxTVBIVFluamNaNVl3NzhmbXRiNHVFUWxyRVVPdUx2K3hYMDBiMU1s?=
 =?utf-8?B?T2RPclpXL0c0bDRSWC9DWlRUek1tZDdnSWoyZll5RldLUmppbFpUZzQ2RTZo?=
 =?utf-8?B?VHIzR0ZOM0ZIZmc0bHV2MkJ5Wnd2VnhrdGwwVGhxSTVzRVdoaW5FQU92d2w5?=
 =?utf-8?B?MFFyZEpQT2tHMUh4YVIvZUFySzBGd2poRmhra2s2dW83cGVpTjZUNG5UZWlw?=
 =?utf-8?B?cnNHcXZsS3FzMjZLNHpXb3Q1SVlvL2o3V2xIbFV5M1A0TThQb0xkRHlqYVlm?=
 =?utf-8?B?dy85S2pUa2dxRnhxVE1HQUV6SkplZDh3VFRPTTFkV3l6Ukw4a1JXMlhuZU9m?=
 =?utf-8?B?d3Nma2ZkM1hLT2ZDMHpTOHg3YzE1S1Z2MTJRK0txeUEwZEh0UWthWnp5TENy?=
 =?utf-8?B?Q0JoQnhVRzg5dTNOQ1BPY1ZBS1pnK295SEo3VlZxb3ZBYmdPRVhQTGMxaXVv?=
 =?utf-8?B?MjdXaFdsU09va3Q5aWt0cytJT1lRSXdpa0Q2K1N4WktEZEJycE1RV0hQUjMx?=
 =?utf-8?B?V3BydkFRek9jV1NCMmI4T1AzS0N3NHpsWndkaUxXclRwSWtFcmNUbE91dkUw?=
 =?utf-8?B?M0NIS0hmWXBnZWlQWG5XcFV6Q1NFZEVuYnhRcXRYYXNlaGxIUi9Makk0WTcx?=
 =?utf-8?B?QmZJbzh2bEJ1Y1Bka2cwSmdlZDA0a2gxeEdUV2dPNjI1b2Rxb0JSWkp0T0pV?=
 =?utf-8?B?KzNVSC95SVByMEhpTTFEdzBDLzQ3aHBCQU9VSmZqSkFMQXZGOEpjNEVPWnVO?=
 =?utf-8?B?VlVUQTB0RFVhSzJsTmthZzlDRmFLcnRRMFlnd05ld1QwR2NmSlVkSFFLNTlO?=
 =?utf-8?B?WGtZQVRla2IwNm9IRnpCQ2lCY1p5TXNUQUZXZ3RZQzVXejkwakh6SGlXL09G?=
 =?utf-8?B?ZHBHd3VyUFh3OFNSSEF1MTd2TkJ2S25uWDdiSlN6WU11N3RVUk8ycGN5UlhE?=
 =?utf-8?B?MFNDaS9td2tMT3h1REY3SW40STFmVExqbWpuaTJUUHRIbHpFaE45ckMrbm55?=
 =?utf-8?B?L1NyRk5XWktSVlNtN3FKQzlVVlVicnhlN1J2RHNLTnBadFZFNm5TQ2ErM25S?=
 =?utf-8?B?WFJiQmtaMUVEU01admNRSjlRSzlkZlZNQS95L2RWNHZ0RDBSdnZrQ2hZZ0ho?=
 =?utf-8?B?c0lRNHVhZW1Ga2tBY1J0VWFjR0t4cTNCRmQzWmhnR1pjQnBEYndLS0VQM2s0?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3iQqdrerrTXGzqH/kBxzXOKvrk25zoL0qV3d+BajyTVPpL4myqCxeJLLyYxJnGn5KF8gp3nAlZ8ZvKfG1kgYcQKrImDwKSebpZog9JCenb4A93lbUbunlRRNtdey7m8KOjQR1bIzUyIVOyeNO8AGliYsL5Mz2xXnSWsj1bnJ7H57EwEO0bBt3N0gT6BMOt1gdDmyUAYqUgDL4lAax40A0cRzhv3TIdCBXduHkRwFbDw+Np74kAfGVubWldFO+HRH7HigRgSja5dY/YImoChX0LmC+BKdlVMOzRkpyKf04RPoH7BwuYfI3qbasKikfdAkcIWP44doq9pQ6qn8dmhDe3CN07T/Z744wPkHy966x68MRYeiX+4h6Y5l02nB40Ew1g/21RPgT5lr2q+5nB39tsRNut1F5WXyBibCqI20fhEd0+PbDgd0Ahj2L9Vq81Ox0llLJQnA+nMkRfOyQortW7dlvypzeJnYyAlCO+VgiRklX/i39GT2pv3OB2wnSQi8PmpwUtR8BNwHdYN0Peu81xr4etGyL80r0vN8TBlX7HDb4vaWWrtR2uEzE3guA/9ItQ2JSCFpCh+8zT4nLGgAp0rXdG3C8N9zM9Azy0RQH/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8759ad-3e0e-4721-5b92-08de01ba042f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:45:58.0671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp6Yw/VJWOhi2K5X4C6dNm2eh2xks0G+SHjmlI7a7LLkMR37uc8s6pnWaKRqu9UBZ8oeai8H8sl49aC8KtNU/COSXduoK/gI76hGZuinBkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NyBTYWx0ZWRfX35MFBmLNiOPn
 B5n0crhc2b3AkXKlIgddoksLd7eznzju6kzM4KXRWUtIHYOSSeKWz7L8sJ0rgoo38ythOieVgQf
 +Mh5XJw+0SkiR0sa3SVx2APkftV2bYFu0Uaib1d4bs3epc2lx6q8sm8D9wo7+ggbUgsfK6Pic19
 uU0mfM6Go/35pt7bmnQ87mUEcmLlkNZ4h6cUzO2zMGl6KgVkLNWNgl5s80uz+HvNYiqqZyIggtS
 q81mifwnO0Mmz73hguqcCTytDK6kHc2NAcW/IAfpsKV/efgIJenPJFK8DVm9WNxe0VgCVeaWqAT
 UeiYhkdQmdFFKFnoAsRV9wQ9faN2IRytJyXSZigxoPSKIM9+Fepfrf8EnbIs7GBP0Jd7pyOhp1f
 NGLNXPhnrCt1ZcL3sjeDyWhzZV+u9w==
X-Authority-Analysis: v=2.4 cv=K/cv3iWI c=1 sm=1 tr=0 ts=68de821c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=p0WdMEafAAAA:8 a=Zc0XKgst8T7VAEIIDkIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yD68TYpiCFQ_rxTjJibl0AAI-JSXGMws
X-Proofpoint-ORIG-GUID: yD68TYpiCFQ_rxTjJibl0AAI-JSXGMws
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/2/2025 4:50 AM, Cédric Le Goater wrote:
> On 10/1/25 22:03, Peter Xu wrote:
>> On Wed, Oct 01, 2025 at 03:07:23PM -0400, Steven Sistare wrote:
>>> That does not make sense.  It already does that, which is why I used it:
>>>
>>> util/memfd.c
>>>
>>> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>>>                        uint64_t hugetlbsize, unsigned int seals, Error **errp)
>>> {
>>>      ...
>>> #ifdef CONFIG_LINUX
>>>      ...
>>>      return mfd;
>>> #else
>>>      error_setg_errno(errp, ENOSYS, "failed to create memfd");
>>> #endif
>>>      return -1;
>>> }
>>>
>>> Did the windows build fail due to a different error?
>>
>> https://gitlab.com/peterx/qemu/-/jobs/11566477462
>>
>> See util/meson.build:
>>
>> if host_os != 'windows'
>>    ...
>>    util_ss.add(files('memfd.c'))
>>    ...
>>
> 
> Steve, you can test the windows build with :
> 
> --cross-prefix=x86_64-w64-mingw32- --disable-sdl --disable-docs

Thanks for the tip, I did not know this incantation - steve


