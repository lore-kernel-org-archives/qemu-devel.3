Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6DCCA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESj3-00058X-58; Wed, 07 Oct 2026 10:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESiO-0004zu-2l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:34:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESiM-0001Bv-Bf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:33:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697DJSEU4056320
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gol/pDe4XsGWL1o6oFednLfIOdkejGBNuhV2bLWATK0=; b=ErOHZxYwq+a5KB9H
 xFgV2DGPmGOLE4DgQJiMTMAxTLqCcMl2Rj2yQkN6T1kuNqCU136Vs/8hM5BtnzdC
 WqtL/4AKgxT0C7XcaW1rEmBKpx1J5SEMbGa+ogLxYDkkN/Foa2hzA8qbQUKG46lA
 WUAEZ68b8rwM1KOHlsLIBWF74mIVk5xKnNDk3FGu69EB0Ty+efyWW7veQbaBJYkk
 UqSrNhLCUBZrOxz3A379x0w0miifSBJg/wfpJ/Dx2tQM0mMAmy29cvNsS6rxaIU/
 9yHym6VvcfrvYc4zdtz+A5+1F0HbsIfFwMqZghaFWG2NjpmWPl0mJfFDdy3bn5V5
 cjcLXg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv7090k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:33:48 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso6323148c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383628; x=1791988428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gol/pDe4XsGWL1o6oFednLfIOdkejGBNuhV2bLWATK0=;
 b=K57/th0JDd6i9aP3lKkjI0ggVzChuuzBun8gUHhvDYhmzLSCCLYe1o4y55enxX6b97
 T33y8ZWR7oGyD5y5DyT6VAeCEbFI1iCjUDYf8JXip67Culn1ADY9VHu4Ys09tDYbWLTt
 QsguyiGz2wZE0ebb5sQval1rwY5Ds51aFWJoURKv82tB8Qzcuf4PKniiWUqFXZzpnJD1
 Cklmt+smeVwi7k4M+Ic6UO7SMaZFNReT0W5axOy+FfDUPC9EXP+ac++6iJkJM3BsCKNG
 ZXBqbuLavNZStd464tzcgSx66URRKTe7xig0wef5SF0MeXHohQeGLwLrChTQwnTvar1h
 l6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383628; x=1791988428;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gol/pDe4XsGWL1o6oFednLfIOdkejGBNuhV2bLWATK0=;
 b=ViYA1/xTCkI3G8clWjOklw0kfNhJB32YiO8EhH1HElSKttHrzy25n5FlYLuP5uu4nG
 xejutYhwek/Wle7/7V4PgfQucdQR6NhSRP45uTvnaXJAouU/WMIFlYoWO608Y/CYBKoT
 szLp5L6BqWC7DY2wOxY9gNti95XTBKlA/mJlktsEZV/VSha++ylQIGFQ16BbhnnJNNq9
 mLe/xQ/DsSqLKA9AbQI7TQlYQjrQ0ntQ4r3Ptwf2CQfQjqatbUC6wJ/tk4LO1TI0yI5u
 xD28zcpzVQVMgalynNAp/JVIm+xPdP2RpEmha2Dsht3+P3eg345kvdeitpvLZszYZQ3S
 nTiA==
X-Gm-Message-State: AFuF++l0E9Ka6XMeF3y4yeeuYFUhWzutrfkl/R1k3TfTafabr39F9IfR
 vC1ZpF6mT9z85ec+Ksh5vi4jG2K3nwFbwjLAbXd1C9wdGtnvI5uaYBWIwN6aOAqhd/kPykfIjBz
 /1rlOLgcpMnjobhZvV0L4C/M/gMY3dGAutLHxRHVuTU3LZ6+QOmx2vXDKQ/tRKCHtqQ==
X-Gm-Gg: AYBFou1CdIjEjhyTUwkIvF1nXELTAkF8UAMDSddURAJqpcJaS3XzmxmYLKcCJ16kHXk
 buVGIZ9SsYVCLk2KWa6SCcrOKswE0ZSgFZRDqryaHkHCTN5Vnk7elxLwZOL1x6XhW/EF9iTs861
 0+AXAncHATRuAufA3XPE7AhqT2S9lCqG1caWtwWlQc3kU0ZmHFIZsC1uIVAoPZffbnLHeZm/L4M
 /VjkgDUf6kel8wdcnRUw2SGOc+/FH3hqXRQwwJZo68stacbOotYelfW9O4NmanXifp50WDUIS4+
 BVSONHA8bM8ozRxaFXZ+D+AixogA1opYNIiDMTcEtqmbQaVhXmltOFOM/yyuCOC7FQEzFW2HGwS
 i9AuArB0UAa5DNEaz2PeM677xuTm+Dd0j1rpct9av76SH7b96vYPVuyUC2olz0f/NQmjzOw==
X-Received: by 2002:a05:701b:450f:10b0:14f:b5ac:ace4 with SMTP id
 a92af1059eb24-1620833ec07mr2356378c88.44.1791383627935; 
 Wed, 07 Oct 2026 07:33:47 -0700 (PDT)
X-Received: by 2002:a05:701b:450f:10b0:14f:b5ac:ace4 with SMTP id
 a92af1059eb24-1620833ec07mr2356334c88.44.1791383627245; 
 Wed, 07 Oct 2026 07:33:47 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af170c5sm10116565eec.11.2026.10.07.07.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:33:46 -0700 (PDT)
Message-ID: <f2dba56f-57ab-4373-bc7a-2b9ae2730e27@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:33:45 -0700
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX+YBmu9LbD8Qd
 KvpdqQbi9HBAeTFz3hVytfDbKT1BV0D55i9Y1N0Ov9qpiRU2cmNh6ZIgVGVJHu1zwR1vW4P/YV3
 kCfVjarbkEBWwxxN4HgWXzGgkDng3cA=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac6584c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dGsWvjqBAAAA:8
 a=69wJf7TsAAAA:8 a=Xwn8AR_0QGYS6JtUd3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22 a=EwAE0RQWx3bH85eTCWcH:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 0RhtEk5v_zl_yteau3QzCCcHc1Bd61FM
X-Proofpoint-GUID: 0RhtEk5v_zl_yteau3QzCCcHc1Bd61FM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX3NUnwDjOeiDD
 AwWtZP3eeBu7dMrvv39Qsmr5FXtzfd0lP5T6m9pYAlC6EmPrMdXlAEuVbFb3dLBF3AOON7TxkM7
 VuGyToTRyuooiVkhXASI0Yxz7/yo5dlOoQDH2o0ZN8KAtkX0XN0cw2VM8AOPpCBAUaa+CdN8F9Z
 z9vBeFVlpJ00jOAlen9xBo9tEF3lKBzxEhtBkOI//LC8QEo6sJ+QFDlM7OMHZpb+Ja8yrYBWMYm
 YCm/WnleiW+xYNFbWXPhu+fJChB86zSHyE2EmZmJHpvP4dBko0xFwyRkeePZ0MIj5ngrocig5MM
 qNabwKAusaOkZPIbW+zEr8Kbqtd9PVVJlrl9MD3ERQx8Xa3yIMHk+FZA+3buq7RatXXk6WuEwIf
 l+pIL10bOOFtBTnC9JfkY9jNp8RF9soiICxYWRDU98G6xk943+BygorJOiBaLhG10LP44e6HVUv
 F+ILZ/+r5phyjQcu8Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070057
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This was merged into master (f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c).

Regards,
Pierrick

