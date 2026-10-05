Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3CECA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnI2-00081O-6P; Mon, 05 Oct 2026 14:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnHF-0007rl-7P
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:19:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnHD-0002H1-Fu
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:19:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HtGsF2046992
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2mgGhLc+TvGlz7fzm9MbjgJEgcVicqjXOAPH7oGsMt0=; b=MIp1P7DHTV7IB4pM
 t4hO5pAkYCr4RNurvhyoITNEBpoUGCtoDmyBd0viEsniycREv9f0lDL1DriVzZzL
 3/OJSW++zWWTkSnGpGMjbpjXdlo5xTCKHClyuBvUI3lBdAoTsGcXQCQChx9O7oPt
 9rU3Dh1rn3LXH0nZhmB+n33oIlJ2oLfluex6Jkrb8iyQoS3dxQ1tgnf/aFh6PrjD
 SQC30JoHcocjzAwokts9c3KfgKkOi48//mN81Fi16g3pqsOOqhnvH/405H5ox5Mw
 1IGl0H8HU+o+R3DyLNl9R7/ekUdL+VVJqWQ5ODGxJ22a3Uq0PGVXWjiGYwjnt+Nk
 3BbXfw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gnb86e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:19:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef5fd7934so5462818eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791224341; x=1791829141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2mgGhLc+TvGlz7fzm9MbjgJEgcVicqjXOAPH7oGsMt0=;
 b=e3N7H/Q1Wy+6DaxuhBAoE6vfNviK38tx29xxk24ARWi35duKBD9v+Vrpug3WAKUfTk
 5XQ/7a7pFFECST7tTcQ8VdqEYnb7ncVeYGHJc5wWmd7Fnum+oPns6eR+cQ5Zb9VXhcW+
 9sFbQ2ho47uWGxlAXW8PxgiYkVi98K62wwi4u1pN3PHm5mHqsRinWHREBsp7F3MeVX+/
 TH9p4pjFQh3zb2NScldsunWw+Y7tCvwe8laNa1xbT5reOc2PNmem/TSAzAHqgYVshaix
 SUQKykL9eW8QV7KhJXC+HmXqYym9HiJ0+o6CHtxDAPRERfVRfT33S73LdNG2yT/15coh
 SVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791224341; x=1791829141;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2mgGhLc+TvGlz7fzm9MbjgJEgcVicqjXOAPH7oGsMt0=;
 b=NbYrdYlbe53T+HldX3lSDQLLdxjSJRxQVjBHL4rokm4jmCvK7rYaFMyrB6nccPUZ0g
 ObAgBNhu/aFh7sAf4tqPU4u60DRmm6RnN8TOO3MFvY31zyO2VnuuLGvYoCChyhlxyIqe
 kJJr7+InB96HEXNEiP1ZPwg4ZUN8hZKYjIl2OkMvXnoUCMd6D8/Jt/pAscttucA4FknN
 X+n0SsoLup5O0iUPemysC4egpMaxJk9SLNx287IFwzJOvSrcCZ76nNCXCXVXISJCXvuF
 bt0V+ZD6rLmdLIEMiHmv7uOGcRcg91nBvX5c1/Q779v6zxWT9Zu1Ko4Ire/sGYO6Ux9x
 7NWA==
X-Gm-Message-State: AFuF++mJrtIFelCTB+/ZsSH00fP6LQYmLh+nqiINHYN4BQ1kn+waedb3
 KnKHBroSN3y0My3z9BP9e1YEqBqm8o5LIPPcdjz17T9Cnm7NNd2FGz51UCZUXHr15fzFs9RfMpy
 ta9+uDh2Gq46MzMRlQb1+NM0es3p43ClzLdWzeO/f+kYVF8WxhoeKo1+3h47QgvrHag==
X-Gm-Gg: AYBFou0VUsDKuAYoUtr+3YyL8ugqkChJDtWc3PPqjPTrpNm6wNoywjFb1uwuJTcP9Lt
 N3W1LJIqrRe0K+oQsAgyJkZ8Bu8egwOF9lCuplgI3d88DG8jKhIuW1XpaS+qedWRufuItWb+lkc
 DX+JsVx/NNyFL3V+k+ZTs4/62hg+K7WNzuoQXqMTu3zMViqwtmGhDI+WREjdV7/FbWkJCo6b6HK
 2F4Q6/GEXptD62Mu2q2kgB3F/HTy6cei5HwsGqyM4MGBK8kM3EWALG61Hra6yi+nXWnYU34IBgV
 0SS6CCTaqCRJtUMwj3QEDMG6zm1xNKX5YvOEWFCV6rqMpW2uIrUOPTp15fmzFuricX9nnT7yeLT
 EHUhJVBicItnAFEtVo1iKi4nNmjloHJcyXZinVaK9/7JwEd1+GArsO2ugZ0MG9w+RhnjsYQ==
X-Received: by 2002:a05:701b:2906:b0:14d:c23e:c931 with SMTP id
 a92af1059eb24-14f5b9fb5d0mr13174118c88.10.1791224340980; 
 Mon, 05 Oct 2026 11:19:00 -0700 (PDT)
X-Received: by 2002:a05:701b:2906:b0:14d:c23e:c931 with SMTP id
 a92af1059eb24-14f5b9fb5d0mr13174087c88.10.1791224340363; 
 Mon, 05 Oct 2026 11:19:00 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d82d04c31sm93414c88.7.2026.10.05.11.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 11:18:59 -0700 (PDT)
Message-ID: <7cdd8a38-0297-4f09-a8da-ddfb8ab09da2@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 11:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix register handle encoding to reserve NULL as
 invalid
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 y zhou <yzhou.dev@outlook.com>, qemu-stable@nongnu.org
References: <20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fmQS4GAF7H28BHR582eMC__Dz7KBk7i5
X-Proofpoint-GUID: fmQS4GAF7H28BHR582eMC__Dz7KBk7i5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX1URcyOwDLrga
 VHmt5Nb5biNKHuXfmD+r/dmGyzdCfXA6P1Lf9edPolT6jb5fpgerouWoWWnMz2KhRG7hfX2k2wd
 W3ihwIT3NiOKsKfJU1pU58eoE1hJiOekuFkeP63x0/DC3BvwA7JeNbz25H5pB6RwpYDndkkydj5
 5pSsniEf9Zg5Gkujt5DbS3LOefllMdUVSV3SY7TW6R6Z16Btyt1K9VEK4lZA04q8v1zxnpRCM6Q
 IAIQWRM2SYrkISmHS8tCr7bhD6HR7t2g/s0xbkcOMT91dWLOpXe9PdL9l3/xEte4sgjjeGIetnG
 aQVizH9wlqpyS8h7Rb/4wTAnrav9wY7i7BaK3PGRYZJu+AVeChQwYieGzPVetG3F0r6+KTw29Z8
 omq7Y50iRPRDsCNYhLx8UZWDs32v0vgWq/jMfgtohZ1YYvMWmeJQ5KO3lUGLt01jVf8TNNaKy2o
 BN6C4H8juL6oCHqqZmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX3FdV640q4rGl
 izb91hrhwfERbhy2NX9zcjIVKs1XZ4vTdKxq9bW37vZzMpaXBEL2AIQGLEQ7RKIkl6jRBHkiHFc
 rq6bcVn4KhCsAAc12wf/7XrsCvNlNww=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac3ea15 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dGsWvjqBAAAA:8
 a=69wJf7TsAAAA:8 a=Xwn8AR_0QGYS6JtUd3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22 a=EwAE0RQWx3bH85eTCWcH:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 10/5/2026 11:18 AM, Pierrick Bouvier wrote:
> From: y zhou <yzhou.dev@outlook.com>
> 
> The opaque register handles returned by qemu_plugin_get_registers()
> are currently encoded as:
> 
>     handle = (gdb_reg << 1) | read_only_bit
> 
> For the first core register of every target -- gdb_reg 0, not
> read-only -- this encodes to GINT_TO_POINTER(0), i.e. NULL. That is
> x86_64 "rax", aarch64 "x0" and ppc "r0", among others.
> 
> A NULL handle is indistinguishable from an invalid one, so any plugin
> that defensively checks its handles silently loses access to the
> first core register (where the Linux syscall number lives on x86_64,
> for example). Passing NULL to qemu_plugin_write_register() instead of
> being rejected silently writes register 0.
> 
> Restore the invariant that NULL is never a valid handle by keeping an
> offset on the gdb register number, as was already done before the
> read-only property was packed into the handle (see v10.0.0, where
> handles were encoded as GINT_TO_POINTER(gdb_reg + 1)):
> 
>     handle = ((gdb_reg + 1) << 1) | read_only_bit
> 
> Also assert in tests/tcg/plugins/registers.c that every descriptor
> carries a non-NULL handle: the current test passes the handles
> straight to read/write without checking them, and a handle encoding
> that maps a valid register to NULL goes unnoticed for that reason.
> 
> Found while writing a system-mode syscall tracing plugin, which could
> read neither the syscall number on x86_64 nor the first argument on
> aarch64 (both handles came back NULL). Auditing every
> GINT_TO_POINTER/GPOINTER_TO_INT site in the tree shows this is the
> only place where a valid entity encodes to NULL.
> 
> Fixes: 55327b85ce32c ("plugins: prohibit writing to read-only registers")
> Signed-off-by: y zhou <yzhou.dev@outlook.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Cc: Alexandre Iooss <erdnaxe@crans.org>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  plugins/api.c                 | 7 ++++---
>  tests/tcg/plugins/registers.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 

Sending this patch on behalf of author, since they have issue to get it
on mailing list.

Regards,
Pierrick

