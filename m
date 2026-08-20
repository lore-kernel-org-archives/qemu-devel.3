Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4674CC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8B7-0003u7-Ns; Thu, 20 Aug 2026 15:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8B4-0003tk-41
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:11:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8B2-0000Pj-Q2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:11:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJBik3009672
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JP0LeHw+NYns/wbYpsLh8I0fRkgmz2gKiAQ/QcK+Fxs=; b=d7Hg6o6/xxr78emk
 COUazV0f9qdiHkDVr7GZpy9AsJOhm5WV50gJKIs/oR2k3I5CIyUWtd6yf6zE1DuZ
 /dfFcCl6PFg+LlZOfDCwsNjfyZAWqq2dV3OSkpR88sXFGdET+J7boscOHXQznplu
 VoYTUbnYyjjIrP2OQyq1dcqNEWxPZbFkU9kPqjIHIUsBrHu3hnJUDubNrnt2AE73
 zAf4+03r85gnzlZNDrEvaTMnXEjsRTiCJLhKt4ro77IgA+DquHdr9tHeVF5nda3q
 hOEVCbaqY7vOGmkBy8KQh7Pm1rybLP6fF7OY8gXOFcl9b9HwayG+pxQ71LJB7zKb
 Fl0YbQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x05tuv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:11:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso196426a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787253107; x=1787857907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JP0LeHw+NYns/wbYpsLh8I0fRkgmz2gKiAQ/QcK+Fxs=;
 b=ftA7IKaQl8edOPXaAwDFd+Rjv8CETAvpyVhLX/qjNjvbfawiO/s4UAKdB8zEwVKtER
 LVOzGWcSPFEMZy0f/4d2ADmawMKUyCdBP4QQXbJ3YqvBXVcWJrcFWE9M6iDl5E6bVMq0
 pMRkns1sjeAb2dpQefGvXElN0LQiEx4HeIS7nQV+oiDLPzWWZDvg6tGb3m0HMVSpSP0q
 pAZYK1T8MpUsX0h4nzFODj9u4N6KKjCspjTEOZNEcKkypBT7XOcFE88GMNuavsBZqAUl
 LD8boI67Smvg0HHtH7Z0g5KnogxM1nD0NPZFdbD17+esEWbXcZMBhbomeIZ89JQhcFaK
 9kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253107; x=1787857907;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JP0LeHw+NYns/wbYpsLh8I0fRkgmz2gKiAQ/QcK+Fxs=;
 b=kzUEUPS4rJ86Vf+fY9RJvSSJc4WhIk6T48ZOLHayfBw3hROyopxnhff3XJlRw1TxEE
 7AUfonxM7WDEi9Ru1nVNnGTdti944SoEGLeXecGAURchZBbP679MxQfeWmB2hcgodIIa
 Ouw7iAJfawglZfWX4m3324MRi1Cx1k83WfMqh5EFK83PkuNaEwRU0dRO36FDrf4QnSnH
 LlI1akWV5i0kAdd8FaZgpzhevO8CQlRDfK4DepPWG0IfE4yrpabgmC1PXXpj/HxJ2k22
 7vRSdok+lrqowhrPAxeJ0Wbi67uXn01/DC68bO8K0Q4dlk7Sjr7qUJd+12d7laoS8RJd
 x0Jw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqf/u2KpUSImhg46DFXK7BMdmpT23b1Pf8nxFeDhUYJIsoGlHQoDH/Y1zL1TrSugXjKEvkmtfaQQlz5@nongnu.org
X-Gm-Message-State: AFuF++nqScP85mSguwUWQfTpBk4zL7Hp72aMk2nMSGUT/HugTCr5dyKg
 jxuzctVl75BkaEnOfFLnLbiI+nYnfjUvhBFssmOZ3WDNqKH5oZpCQvislVHUsoHl20YODLx5Ztg
 aC3MzcvWpy4a83MiSIj+91gV1DfGcg88+AdfwZ0abGVOShLjb7RIIjWe/Lg==
X-Gm-Gg: AR+sD1324nbN9M6rcLiIMHcAC2VfNzmHDYzlIJ15Ou+i1gt3C76Lo7/JueMdZm+cqA6
 DN13zy3YbDIZM9oMAzpp0npvhnnGbDd0AvSN22NdhYFz0Jl4oVQX3Eqwwqy93Djx18MgrkXxYR4
 UDCum6pCp2hwOU+XGqjmvpJt9oy5at30THTh0zWcVlumx/jTxCK14carGc97T+ttTRtC0FiN3wg
 L0gzJv4B39w45hbR5olgAXTGW1u70DTeDk/oLJPv4PrM/K5Tsdaqj1WdIChmI/oj+JTxEuya5NF
 ColroSEKLJ64z9CYJK6rSLAOpJUtXVoT1eFyZI2ZZCxU+zhAXXZvm1ZH+884C7sDkocWLD3GkkY
 OgjJ/99Kbs5fZIPj4DlW0FmWHCsFZkBVKCBkY2ZTkvDWwlr1nSyW4iNjVG6uxu4KtlPn3
X-Received: by 2002:a17:90b:3d8a:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-395c353e28dmr1287436a91.5.1787253106783; 
 Thu, 20 Aug 2026 12:11:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8a:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-395c353e28dmr1287366a91.5.1787253106381; 
 Thu, 20 Aug 2026 12:11:46 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf191821sm18470182eec.28.2026.08.20.12.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:11:45 -0700 (PDT)
Message-ID: <4ee97627-9e72-462b-bd1c-399a7ebf0141@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:11:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/hexagon: add icinva test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
 <20260819045339.3661773-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819045339.3661773-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h-2RJPqfCXe6HDnO-aRWImhYeoN9BGdG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NCBTYWx0ZWRfX6VI3hr/13Qpc
 xtQUvZXNsU3nS/PSvkKOY9eGa9nOzqd63mug5XhJPE3C7Ew0xoTF9THysOjMR21UKwYAZZ/3Cdq
 vhGKPPkf/l4ooWS/l17b340ICDikPekkQj2jfJWRzqnQrmzVQgGCbQJ7M+F5y0bZ9a99+2em4Ok
 5B5NNssieQBl723Di1MoQLc0zwpmVPrmtpRg0oW/TyHnJ57ELl6bbnFCAKyMfnsUdl/9JhG8Eal
 PLjPTQofmBnAVeCtF9xsDqai8hEfStZ5LyoBAjtaBv5gqyj0jfYe8juukceKZdBPG+yXO28LQon
 SjXfo3dd81V2oVaFAqP9tx5oVWQEl9TIiRTKLEt/dybusiLyj0+CbDRdSdepDtkuhmgvtNTMElE
 LNCGyRxxDWLUhAMIDQARBFAMdFp2/r25+5f6kSXuKUYUhjpwP1vXvRcBSIulOVSvCUEwH6Zo2C+
 aWWfuCSgVqA8pxA3/tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NCBTYWx0ZWRfX4o5flxJexDvp
 ADtrk/88NANxD8FxcojG+t48IyKW/dXT/WW+thson1UyokuPfStk2wPG/0/dkXmNQvdKK9j8naf
 XeMGEhAebz+Ydb0ljatQLYqzeOZpWnU=
X-Authority-Analysis: v=2.4 cv=VfPH+lp9 c=1 sm=1 tr=0 ts=6a875173 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_dax7Ao1p6467GrWFS8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: h-2RJPqfCXe6HDnO-aRWImhYeoN9BGdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/18/2026 9:53 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/icinva.c        | 71 +++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |  2 +
>  2 files changed, 73 insertions(+)
>  create mode 100644 tests/tcg/hexagon/icinva.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

