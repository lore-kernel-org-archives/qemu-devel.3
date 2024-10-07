Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E3CCFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqSE-0002Mq-7S; Mon, 07 Oct 2024 12:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sxqSC-0002MZ-CM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:19:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sxqS8-0006Vq-Qf
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:19:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497F6fAO004196;
 Mon, 7 Oct 2024 16:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T17uOxxCVZEJiv4uvfYynpTWVoTaDLd28+IXgCIc3DE=; b=RFG59YQzm/KTxGze
 HDIz0dP1kBMEywfJXJfmQRtlz4JOnEjOr9iReCrF7nNhC4f5/v8+FWGm7yfk79Pw
 BnInjj8ucAeRWTMFmYuUZ2nxaMZzABh5bLKewlRcWTmJsM6FleilCU0VHL9Bca+f
 0X0VyFsj76emXsQEhoaUuh5NNP7ZCmG2Ssw5nfspKYPKapvGNvG/8wFHynWdk4sH
 aG7ytaDYvqNqLysXhuEu75qJNnoHNII7takWILdZg6POW9EMX34iZcrW1LEacRim
 9/oHljWcTCwn7neKl4GtSBZdKtIQcR7uMuQojibziK3AZh/OlctsuPaLCc9aTocP
 I9VpyA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xqnvpq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 16:19:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497GJHDs027330
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 7 Oct 2024 16:19:17 GMT
Received: from [10.111.168.217] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 09:19:16 -0700
Message-ID: <0ac9546e-2b0d-46f1-8c5c-fc75529aa682@quicinc.com>
Date: Mon, 7 Oct 2024 11:19:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scripts: validate SPDX license choices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20241007154548.1144961-1-berrange@redhat.com>
 <20241007154548.1144961-3-berrange@redhat.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241007154548.1144961-3-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 7QXP0_bLpE31L5rDro7uXXmf5OwD6_SC
X-Proofpoint-GUID: 7QXP0_bLpE31L5rDro7uXXmf5OwD6_SC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=799 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070115
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 10/7/2024 10:45 AM, Daniel P. Berrangé wrote:
> We expect all new code to be contributed with the "GPL-2.0-or-later"
> license tag. Divergance is permitted if the new file is derived from
> pre-existing code under a different license, whether from elsewhere
> in QEMU codebase, or outside.
>
> Issue a warning if the declared license is not "GPL-2.0-or-later",
> and an error if the license is not one of the handful of the
> expected licenses to prevent unintended proliferation.
>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 66 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index cc266abdcd..cd1ed90f4c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1353,6 +1353,67 @@ sub checkfilename {
>   	}
>   }
>   
> +sub checkspdx {
> +    my ($file, $expr) = @_;
> +
> +    # Imported Linux headers probably have SPDX tags, but if they
> +    # don't we're not requiring contributors to fix this
> +    if ($file =~ m,include/standard-headers, ||
> +	$file =~ m,linux-headers,) {
> +	return;
> +    }
> +
> +    my $origexpr = $expr;
> +
> +    # Flatten sub-expressions
> +    $expr =~ s/\(|\)/ /g;
> +    $expr =~ s/OR|AND/ /g;
> +
> +    # Merge WITH exceptions to the license
> +    $expr =~ s/\s+WITH\s+/-WITH-/g;
> +
> +    # Cull more leading/trailing whitespace
> +    $expr =~ s/^\s*//g;
> +    $expr =~ s/\s*$//g;
> +
> +    my @bits = split / +/, $expr;
> +
> +    my $prefer = "GPL-2.0-or-later";
> +    my @valid = qw(
> +	LGPL-2.0-or-later
> +	LGPL-2.1-or-later
> +	GPL-2.0-only
> +	LGPL-2.0-only
> +	LGPL-2.0-only
> +	BSD-2-Clause
> +	BSD-3-Clause
> +	MIT
> +	);
> +
> +    my $nonpreferred = 0;
> +    my @unknown = ();
> +    foreach my $bit (@bits) {
> +	if ($bit eq $prefer) {
> +	    next;
> +	}
> +	if (grep /^$bit$/, @valid) {
> +	    $nonpreferred = 1;
> +	} else {
> +	    push @unknown, $bit;
> +	}
> +    }
> +    if (@unknown) {
> +	ERROR("Saw unacceptable licenses '" . join(',', @unknown) .
> +	      "', valid choices for QEMU are:\n" . join("\n", $prefer, @valid));
> +    }
> +
> +    if ($nonpreferred) {
> +	WARN("Saw acceptable license '$origexpr' but note '$prefer' is preferred " .
> +	     "for new files unless the code is derived from a source with an" .
> +	     "existed declared license that must be followed.");

Is it not preferred to contribute code under the BSD-3-clause? Based on 
other items in the project, I was expecting we could make contributions 
for hexagon w/BSD.  But those are exceptional cases and not to be 
followed in the general case?


> +    }
> +}
> +
>   sub process {
>   	my $filename = shift;
>   
> @@ -1641,6 +1702,11 @@ sub process {
>   		    }
>   		}
>   
> +# Check SPDX-License-Identifier references a permitted license
> +		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
> +		    &checkspdx($realfile, $1);
> +		}
> +
>   # Check for wrappage within a valid hunk of the file
>   		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
>   			ERROR("patch seems to be corrupt (line wrapped?)\n" .

