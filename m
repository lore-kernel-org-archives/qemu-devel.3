Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE8C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7ka-0003Re-QB; Thu, 20 Aug 2026 14:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7kZ-0003RK-He
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:44:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7kX-0004uw-M1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:44:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJLmh352487
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CYFRXiuUWneGvXYjztda1KyCLZt2zjxKes58BRUutLQ=; b=Ss2s5pmyVtgWYCsh
 +7STohREk6u1TPPI0tZxXjtltf93gx/DzjdtD11Jn+8IqUCa0nPSuPXsl/LuJY+3
 mvr5CV/9t4G7IM0maQdp4T/49wIiempChSnKQX8yXnHs04yVrx0DjWs1j9gx33b4
 bQD5kxt0f1OQiETf65C4Vh5Ta+7PbtvVosF8Cfq/jUm+KZ4RFuC4R8h154bCiToy
 7bpyq2DliLJj47GcZJ1fPtY0BXw/8X6qTAiKzv4tOzh2pmpcC35sSE1xGWPtekQo
 CdcGztYCE3K5ouwoyDWsPraMZpfo0THnypGgXxTQrkAl4p5n8zE8ukBZwVXMmUhz
 DlEVpA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8aamq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:44:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbee5bab340so239414a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251462; x=1787856262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CYFRXiuUWneGvXYjztda1KyCLZt2zjxKes58BRUutLQ=;
 b=AWOBh5kb3EIir6GrOLrmW+DaUeR/gS1h3dIRj1f8CuYdH8MNTs4zvD6RbpMovA5MfD
 t4+vbgOIg/Oz7uYD/S8TtGcpSWuThYgVK+jxy+Qhu/WECOl78DIyupsvHY1dpd3Mo+8w
 qg7ga9Mq+24WjvgnKgBzMKwwYX1L1d+0GjKp5f36luGnhTUQv7wpqYSSQDNyZqtc6M/d
 g3Lo8pBEk3OKnSh3hAZWc+r724KBecyYUDq42pup7H4KqwXIMg/qOaMHLIbIEJfT+C7n
 ib3e2/NDWm0T7Uub/SYTqeo5jzUxIxk2txDP/m6fapLAuXwUfQS9kzAE6/WHAxShnDON
 OEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251462; x=1787856262;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CYFRXiuUWneGvXYjztda1KyCLZt2zjxKes58BRUutLQ=;
 b=biFKUmpp3U8qmWwQxuQYIunp2HRx6f5DY4CcPqDPOzLTXeKa8aR9bHoTKR1ggxwOSa
 WeJXrTezL5iOF5cUdQO16KZWGe43SbDAM1UrB5UrTb6pvgekwfdFrqjqh36nqymaPfz6
 NwcDBuxcB95pgNSLWSiZk62DrOaaFjVupCLJIcBUSofoaPED/188bdoSqED2A/MFOneN
 TPqeofVyeRQh/2hI3MtDMKisESpOHhrRZ6ffzg8ya5h4N1XxrqJKu5V+2d7IcjMoshMQ
 1R3k20PzvtlgTJ43euWzjymlNy6xLA1JfivOjxIrbC+ztEPaP8mZaXsvPiPnZbQJhotJ
 LXkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RojEBNSJi55qS8/PvWQUsS1e5Ffj1J6i2SHDk8iGT8guLnKMzMbr+WcGHeNYcHNfQZXHHXLMWpaSvwd@nongnu.org
X-Gm-Message-State: AOJu0YzdLrfnKs3CJQ7h2lGBuLXjsjxI/cezhFbCRCnRHdn2nWy5/PpY
 DCmfBJhNJgfrYK1YLe3TN72sp+j3Ofnd3kEA0jgw0sE5FO8KaXgF8T/Y8+RnVfQzZIDTTDYJX39
 JDiNIb0GpUL2haUvrBKoVM55i7DmuICfLz8eemHNwsqSKHFpm21ykXwTzHQ==
X-Gm-Gg: AR+sD102P9okNix7ALOjpc656xXoVD6SQSBu9iFLpu+/VxS+VTxCE7zcGvCBcmpeNsn
 hYondx80k3Eb1rtL2/R8Vgk+iPCoXNvLBIO3+ZnkWcR+8Jgf9+1JuC403w2CHv40aJzjtbyMFuz
 W0oZD/flEo4nn29FI1OmW6onAPZMrtIr4oi+qEWL8YRaM0puFhNiuVkyhfXF7pGLL0FPY2Ao/g3
 cK0XlTsKZFps5IQilsHCRbFnCCw/B63+knUDqRC064qmiGpZROvPlYFcM2mNkhXh8WvpND+kRnq
 AhBRdq5nKJ03j2Arnamyn8MSg6gjiQ2qnW+tOSaX7L055ZtyY6hlUku1ratEGLVBG27DA5W/ffn
 Chi9PKdki45duxfE47c8qc2szzxKNqFezzd7sv2kP0dSk4K0TrItlOIzN7N0nPdVWuZkk
X-Received: by 2002:a05:6a20:c70a:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cd3008be8amr984749637.12.1787251462462; 
 Thu, 20 Aug 2026 11:44:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:c70a:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cd3008be8amr984680637.12.1787251462042; 
 Thu, 20 Aug 2026 11:44:22 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bec30f49sm16896793eec.0.2026.08.20.11.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:44:21 -0700 (PDT)
Message-ID: <1d9ef45d-8d1b-45e5-b947-f87dab34fb4b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:44:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/hexagon: guard writes to unimplemented guest
 registers
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfXwAmdJxAWyUY4
 0UR/wwb7xCmtlbXpXX9pq/TkH1XfYI+cjkelo7FxGjoUsKxapwj6r3eqorCtX2mfglWRqNJJW8G
 p7KSZmph/3kwck/6jKbLjIOGm1BhHPo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX8OQzEDNm+mCj
 EYc9V/yUxkidpovG9KYi8iaGh9Q5sK9xD00ojAgymqjet/zHcnIH/nLfnrIE/QxaARvyNg0hRYW
 tiREyRwh1aQ0WozULen2E911AiojGqGcUQNjvWJSO8RiMbAxooh1QN+KIz8eVPKH6XcGmnpLFat
 JuldMlQ484z5qZQXAzQ1TCgQyAe1CFbwj+7scZ+5VP2NvuOQlJ1EHpBeo/hkbg+HhBXXc/wxZ8W
 4VsGTIk8kQdZ/l9MPaBL+2wBN8EfckiOw2K5YWNEIioHuO4ZyZnmv4VBdVBjbRmpZ1+V6ofirs0
 8TDd2uuSQY0x8hozTf0hL5Rx/pVOMp3mP7WNdbtSH4F4tZ+7m1cx00QUie7rIt5PKLC2fpZHToh
 ZTFjmG8LPi8YcAy/elJqkcO6tXoVxzBQc5DVjhuUaZF9yWwf/wv8nh1/V9dz9ufk1a8ZS91V7fm
 cuh7pJ7MTWgA70vcXbA==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a874b07 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=igi6GqxGHG0Xb9lAMXwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 1nJ3L2VSYLFnnMV8XoO2jHFcaugjq1HG
X-Proofpoint-ORIG-GUID: 1nJ3L2VSYLFnnMV8XoO2jHFcaugjq1HG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200140
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> Gate guest-register writes on greg_writable() in the generated code so
> writes to gregs above G3 are dropped instead of dereferencing an
> unallocated TCG temp.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h   |  7 ++++---
>  target/hexagon/hex_common.py | 18 +++++++++++++++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 00de2b0d2ec..05425d92b29 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -97,9 +97,10 @@ bool is_gather_store_insn(DisasContext *ctx);
>  #ifndef CONFIG_USER_ONLY
>  static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
>  {
> -    assert(rnum <= HEX_GREG_G3);
> -    ctx->greg_log[ctx->greg_log_idx] = rnum;
> -    ctx->greg_log_idx++;
> +    if (rnum <= HEX_GREG_G3) {
> +        ctx->greg_log[ctx->greg_log_idx] = rnum;
> +        ctx->greg_log_idx++;
> +    }
>  }
>

I'm not sure how this change is related to what is given in written
message. The functional change here is that we'll ignore write, instead
of asserting. Is that still expected to have a write on a wrong register
anyway?

If not, maybe we should at least log a guest_error instead of silently
ignoring it.

>  static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index e33d43e3ce0..c180c19b092 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -1097,11 +1097,24 @@ def analyze_write(self, f, tag, regno):
>          """))
>  
>  class GuestRegister(Register):
> -    pass
> +    def gen_check_impl(self, f, regno):
> +        if self.is_written():
> +            f.write(code_fmt(f"""\
> +                if (!greg_writable(insn->regno[{regno}],
> +                    {str(self.is_pair()).lower()})) {{
> +                    return;
> +                }}
> +            """))
> +        else:
> +            f.write(code_fmt(f"""\
> +                check_greg_impl(insn->regno[{regno}],
> +                                {str(self.is_pair()).lower()});
> +            """))
>  
>  class GuestDest(GuestRegister, Single, Dest):
>      def decl_tcg(self, f, tag, regno):
>          self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
>          f.write(code_fmt(f"""\
>              TCGv_i32 {self.reg_tcg()} = tcg_temp_new_i32();
>          """))
> @@ -1121,6 +1134,7 @@ def decl_reg_num(self, f, regno):
>          """))
>      def decl_tcg(self, f, tag, regno):
>          self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
>          f.write(code_fmt(f"""\
>              TCGv_i32 {self.reg_tcg()} = tcg_temp_new_i32();
>              gen_read_greg({self.reg_tcg()}, {self.reg_num});
> @@ -1131,6 +1145,7 @@ def analyze_read(self, f, regno):
>  class GuestPairDest(GuestRegister, Pair, Dest):
>      def decl_tcg(self, f, tag, regno):
>          self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
>          f.write(code_fmt(f"""\
>              TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
>          """))
> @@ -1150,6 +1165,7 @@ def decl_reg_num(self, f, regno):
>          """))
>      def decl_tcg(self, f, tag, regno):
>          self.decl_reg_num(f, regno)
> +        self.gen_check_impl(f, regno)
>          f.write(code_fmt(f"""\
>              TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
>              gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});


