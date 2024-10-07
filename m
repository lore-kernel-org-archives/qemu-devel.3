Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEE7CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqLq-0000yE-UB; Mon, 07 Oct 2024 12:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sxqLo-0000y5-LY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:12:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sxqLl-0005g5-1O
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:12:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497F6fDg003930;
 Mon, 7 Oct 2024 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1MjTtkvMjyOgc0ZbCwQBoKvvfnej7uN5ZnpfCOGi1Fw=; b=I4RhnQVrE1UT19VF
 Wy+lOCrw7FfAY3IcjjP5mSVPWk5Wk6512WjvA78kY9mAvCt5IoSBKRVW4YaRFnRf
 fuulgxte6EKS6F5i2rI/xiYNdbjwXS9mIY8OvIFglUVrZjjnfWbToJvd9SipDUt1
 XToh4JmG7SHFTWH7ki5iGY+bR5/xc/paPuR2JjDTKFEu9c9WY1ODRBFaPU37XWBd
 rHzJfd1Bd7ItRjOTw0SzrCnSV7ClFXHgIRiv4HdnBqE4+5SCuwF++a3sEeDWyrnJ
 xq9943W/trE/TePXtvOCAQvuJD3CmRWrVJMeJjj5pWBPobkYrJy4m8bszWjBm5SY
 GbWkuA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xv6vref-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 16:12:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497GCdr4025906
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 7 Oct 2024 16:12:39 GMT
Received: from [10.111.168.217] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 09:12:39 -0700
Message-ID: <d9ffbc39-3fc6-49df-9140-9b5aeacc24d0@quicinc.com>
Date: Mon, 7 Oct 2024 11:12:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scripts: mandate that new files have
 SPDX-License-Identifier
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20241007154548.1144961-1-berrange@redhat.com>
 <20241007154548.1144961-2-berrange@redhat.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241007154548.1144961-2-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 78GpBbWr7pZ4ELwXayNEiFlXwqXwbBkH
X-Proofpoint-GUID: 78GpBbWr7pZ4ELwXayNEiFlXwqXwbBkH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070115
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
> Going forward we want all newly created source files to have an
> SPDX-License-Identifier tag present.
>
> Initially mandate this for C, Python and Perl source files, and
> encourage this for other file types.
>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b21249c91..cc266abdcd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1378,6 +1378,8 @@ sub process {
>   	my $in_imported_file = 0;
>   	my $in_no_imported_file = 0;
>   	my $non_utf8_charset = 0;
> +	my $expect_spdx = 0;
> +	my $expect_spdx_file;
>   
>   	our @report = ();
>   	our $cnt_lines = 0;
> @@ -1615,6 +1617,30 @@ sub process {
>   			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>   		}
>   
> +# All new files should have a SPDX-License-Identifier tag
> +		if ($line =~ /^new file mode\s*\d+\s*$/) {
> +		    if ($expect_spdx) {
> +			if ($expect_spdx_file =~ /\.(c|h|py|pl|c\.inc)$/) {
> +			    # source code files MUST have SPDX license declared
> +			    ERROR("expected 'SPDX-License-Identifer' in new file $expect_spdx_file");
> +			} else {
> +			    # Other files MAY have SPDX license if appropriate
> +			    WARNING("Does new file $expect_spdx_file need 'SPDX-License-Identifer'?");
> +			}
> +		    }
> +		    $expect_spdx = 1;
> +		    $expect_spdx_file = undef;
> +		} elsif ($expect_spdx) {
> +		    $expect_spdx_file = $realfile unless defined $expect_spdx_file;
> +
> +		    # SPDX tagsd may occurr in comments which were
> +		    # stripped from '$line', so use '$rawline'
> +		    if ($rawline =~ /SPDX-License-Identifier/) {
> +			$expect_spdx = 0;
> +			$expect_spdx_file = undef;
> +		    }
> +		}
> +
>   # Check for wrappage within a valid hunk of the file
>   		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
>   			ERROR("patch seems to be corrupt (line wrapped?)\n" .

This change makes sense to me, thanks for suggesting it.


Reviewed-by: Brian Cain <bcain@quicinc.com>


