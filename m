Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B092CD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slrtm-0001dN-TU; Wed, 04 Sep 2024 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slrti-0001bC-2O; Wed, 04 Sep 2024 11:26:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slrtf-0006FM-5I; Wed, 04 Sep 2024 11:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725463566; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=YFVzdlBcISTW5f+IlB4+ZoCNpWUmK1nhHX9vVW8deBs=;
 b=gKC38CpeAbMYe/U/twilH0Jwt41imcCU2eetmsaTMP6ILG7y8t+RFbVDzIzNbtSMHZfr/zVk/SxTH3zn2veKlV20Xvq61oeMqcUbTuedGU3n5167/zowqQt7bk3PiNS+SgLk2H68SGTmOgP/utwXpdopnyvkISLhO7k8ZX//UxE=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEIAef8_1725463564) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 23:26:06 +0800
Content-Type: multipart/alternative;
 boundary="------------QG0ZpmxfaGqLM0th5Y2Baedl"
Message-ID: <141dbbff-55f6-4628-9701-554b0d32440d@linux.alibaba.com>
Date: Wed, 4 Sep 2024 23:25:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] tcg/riscv: Implement vector roti/v/x shi ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-14-zhiwei_liu@linux.alibaba.com>
 <97873524-9e47-44c4-b34a-a27e9833b0e1@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <97873524-9e47-44c4-b34a-a27e9833b0e1@linaro.org>
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------QG0ZpmxfaGqLM0th5Y2Baedl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/9/3 23:15, Richard Henderson wrote:
> On 8/29/24 23:16, LIU Zhiwei wrote:
>> @@ -2589,6 +2605,69 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType 
>> type, unsigned vece,
>>               }
>>           }
>>           break;
>> +    case INDEX_op_shli_vec:
>> +        if (a2 > 31) {
>> +            tcg_gen_shls_vec(vece, v0, v1, tcg_constant_i32(a2));
>> +        } else {
>> +            vec_gen_3(INDEX_op_rvv_shli_vec, type, vece, 
>> tcgv_vec_arg(v0),
>> +                      tcgv_vec_arg(v1), a2);
>> +        }
>> +        break;
>> +    case INDEX_op_shri_vec:
>> +        if (a2 > 31) {
>> +            tcg_gen_shrs_vec(vece, v0, v1, tcg_constant_i32(a2));
>> +        } else {
>> +            vec_gen_3(INDEX_op_rvv_shri_vec, type, vece, 
>> tcgv_vec_arg(v0),
>> +                      tcgv_vec_arg(v1), a2);
>> +        }
>> +        break;
>> +    case INDEX_op_sari_vec:
>> +        if (a2 > 31) {
>> +            tcg_gen_sars_vec(vece, v0, v1, tcg_constant_i32(a2));
>> +        } else {
>> +            vec_gen_3(INDEX_op_rvv_sari_vec, type, vece, 
>> tcgv_vec_arg(v0),
>> +                      tcgv_vec_arg(v1), a2);
>> +        }
>> +        break;
>> +    case INDEX_op_rotli_vec:
>> +        t1 = tcg_temp_new_vec(type);
>> +        tcg_gen_shli_vec(vece, t1, v1, a2);
>> +        tcg_gen_shri_vec(vece, v0, v1, (8 << vece) - a2);
>> +        tcg_gen_or_vec(vece, v0, v0, t1);
>> +        tcg_temp_free_vec(t1);
>> +        break;
>> +    case INDEX_op_rotls_vec:
>> +        t1 = tcg_temp_new_vec(type);
>> +        t2 = tcg_temp_new_i32();
>> +        tcg_gen_neg_i32(t2, temp_tcgv_i32(arg_temp(a2)));
>> +        tcg_gen_shrs_vec(vece, v0, v1, t2);
>> +        tcg_gen_shls_vec(vece, t1, v1, temp_tcgv_i32(arg_temp(a2)));
>> +        tcg_gen_or_vec(vece, v0, v0, t1);
>> +        tcg_temp_free_vec(t1);
>> +        tcg_temp_free_i32(t2);
>> +        break;
>
> I'm trying to work out how much benefit there is here of expanding 
> these early, as opposed to simply using TCG_REG_TMP0 when the 
> immediate doesn't fit,

We find for rotli,  it just copied code from the implementation of 
INDEX_op_shli_vec and INDEX_op_shri_vec if we don't expand it.

   case INDEX_op_rotli_vec:
         if (a2 > 31) {
             tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, a2);
             tcg_out_opc_vx(s, OPC_VSLL_VX, TCG_REG_V0, a1, TCG_REG_TMP0, true);
         } else {
             tcg_out_opc_vi(s, OPC_VSLL_VI, TCG_REG_V0, a1, a2, true);
         }

         if ((8 << vece) - a2) > 31) {
             tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, 8 << vece) - a2);
             tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, TCG_REG_TMP0, true);
         } else {
             tcg_out_opc_vi(s, OPC_VSRL_VI, a0, a1, 8 << vece) - a2, true);
         }
         tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0, true);
         break;

Thus, I prefer to expand it early, at least for rotli_vec.

Thanks,
Zhiwei

> or for rotls_vec negation.
>
>> +    case INDEX_op_rotlv_vec:
>> +        v2 = temp_tcgv_vec(arg_temp(a2));
>> +        t1 = tcg_temp_new_vec(type);
>> +        tcg_gen_neg_vec(vece, t1, v2);
>> +        vec_gen_3(INDEX_op_shrv_vec, type, vece, tcgv_vec_arg(t1),
>> +                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
>> +        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(v0),
>> +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
>> +        tcg_gen_or_vec(vece, v0, v0, t1);
>> +        tcg_temp_free_vec(t1);
>> +        break;
>> +    case INDEX_op_rotrv_vec:
>> +        v2 = temp_tcgv_vec(arg_temp(a2));
>> +        t1 = tcg_temp_new_vec(type);
>> +        tcg_gen_neg_vec(vece, t1, v2);
>> +        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
>> +                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
>> +        vec_gen_3(INDEX_op_shrv_vec, type, vece, tcgv_vec_arg(v0),
>> +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
>> +        tcg_gen_or_vec(vece, v0, v0, t1);
>> +        tcg_temp_free_vec(t1);
>> +        break;
>
> And here we can use TCG_REG_V0 as the temporary, both for negation and 
> shift intermediate.
>
>     vrsub_vi  V0, a2, 0
>     vshlv_vv  V0, a1, V0
>     vshrv_vv  a0, a1, a2
>     vor_vv    a0, a0, V0
>
>
> r~
--------------QG0ZpmxfaGqLM0th5Y2Baedl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024/9/3 23:15, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:97873524-9e47-44c4-b34a-a27e9833b0e1@linaro.org">On
      8/29/24 23:16, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">@@ -2589,6 +2605,69 @@ void
        tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
        <br>
                      }
        <br>
                  }
        <br>
                  break;
        <br>
        +    case INDEX_op_shli_vec:
        <br>
        +        if (a2 &gt; 31) {
        <br>
        +            tcg_gen_shls_vec(vece, v0, v1,
        tcg_constant_i32(a2));
        <br>
        +        } else {
        <br>
        +            vec_gen_3(INDEX_op_rvv_shli_vec, type, vece,
        tcgv_vec_arg(v0),
        <br>
        +                      tcgv_vec_arg(v1), a2);
        <br>
        +        }
        <br>
        +        break;
        <br>
        +    case INDEX_op_shri_vec:
        <br>
        +        if (a2 &gt; 31) {
        <br>
        +            tcg_gen_shrs_vec(vece, v0, v1,
        tcg_constant_i32(a2));
        <br>
        +        } else {
        <br>
        +            vec_gen_3(INDEX_op_rvv_shri_vec, type, vece,
        tcgv_vec_arg(v0),
        <br>
        +                      tcgv_vec_arg(v1), a2);
        <br>
        +        }
        <br>
        +        break;
        <br>
        +    case INDEX_op_sari_vec:
        <br>
        +        if (a2 &gt; 31) {
        <br>
        +            tcg_gen_sars_vec(vece, v0, v1,
        tcg_constant_i32(a2));
        <br>
        +        } else {
        <br>
        +            vec_gen_3(INDEX_op_rvv_sari_vec, type, vece,
        tcgv_vec_arg(v0),
        <br>
        +                      tcgv_vec_arg(v1), a2);
        <br>
        +        }
        <br>
        +        break;
        <br>
        +    case INDEX_op_rotli_vec:
        <br>
        +        t1 = tcg_temp_new_vec(type);
        <br>
        +        tcg_gen_shli_vec(vece, t1, v1, a2);
        <br>
        +        tcg_gen_shri_vec(vece, v0, v1, (8 &lt;&lt; vece) - a2);
        <br>
        +        tcg_gen_or_vec(vece, v0, v0, t1);
        <br>
        +        tcg_temp_free_vec(t1);
        <br>
        +        break;
        <br>
        +    case INDEX_op_rotls_vec:
        <br>
        +        t1 = tcg_temp_new_vec(type);
        <br>
        +        t2 = tcg_temp_new_i32();
        <br>
        +        tcg_gen_neg_i32(t2, temp_tcgv_i32(arg_temp(a2)));
        <br>
        +        tcg_gen_shrs_vec(vece, v0, v1, t2);
        <br>
        +        tcg_gen_shls_vec(vece, t1, v1,
        temp_tcgv_i32(arg_temp(a2)));
        <br>
        +        tcg_gen_or_vec(vece, v0, v0, t1);
        <br>
        +        tcg_temp_free_vec(t1);
        <br>
        +        tcg_temp_free_i32(t2);
        <br>
        +        break;
        <br>
      </blockquote>
      <br>
      I'm trying to work out how much benefit there is here of expanding
      these early, as opposed to simply using TCG_REG_TMP0 when the
      immediate doesn't fit,</blockquote>
    <p>We find for rotli,  it just copied code from the implementation
      of INDEX_op_shli_vec and INDEX_op_shri_vec if we don't expand it.<br>
    </p>
    <pre>  case INDEX_op_rotli_vec:
        if (a2 &gt; 31) {
            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, a2);
            tcg_out_opc_vx(s, OPC_VSLL_VX, TCG_REG_V0, a1, TCG_REG_TMP0, true);
        } else {
            tcg_out_opc_vi(s, OPC_VSLL_VI, TCG_REG_V0, a1, a2, true);
        }

        if ((8 &lt;&lt; vece) - a2) &gt; 31) {
            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, 8 &lt;&lt; vece) - a2);
            tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, TCG_REG_TMP0, true);
        } else {
            tcg_out_opc_vi(s, OPC_VSRL_VI, a0, a1, 8 &lt;&lt; vece) - a2, true);
        }
        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0, true);
        break;</pre>
    <p>Thus, I prefer to expand it early, at least for rotli_vec.</p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <blockquote type="cite"
      cite="mid:97873524-9e47-44c4-b34a-a27e9833b0e1@linaro.org"> or for
      rotls_vec negation.
      <br>
      <br>
      <blockquote type="cite">+    case INDEX_op_rotlv_vec:
        <br>
        +        v2 = temp_tcgv_vec(arg_temp(a2));
        <br>
        +        t1 = tcg_temp_new_vec(type);
        <br>
        +        tcg_gen_neg_vec(vece, t1, v2);
        <br>
        +        vec_gen_3(INDEX_op_shrv_vec, type, vece,
        tcgv_vec_arg(t1),
        <br>
        +                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
        <br>
        +        vec_gen_3(INDEX_op_shlv_vec, type, vece,
        tcgv_vec_arg(v0),
        <br>
        +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
        <br>
        +        tcg_gen_or_vec(vece, v0, v0, t1);
        <br>
        +        tcg_temp_free_vec(t1);
        <br>
        +        break;
        <br>
        +    case INDEX_op_rotrv_vec:
        <br>
        +        v2 = temp_tcgv_vec(arg_temp(a2));
        <br>
        +        t1 = tcg_temp_new_vec(type);
        <br>
        +        tcg_gen_neg_vec(vece, t1, v2);
        <br>
        +        vec_gen_3(INDEX_op_shlv_vec, type, vece,
        tcgv_vec_arg(t1),
        <br>
        +                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
        <br>
        +        vec_gen_3(INDEX_op_shrv_vec, type, vece,
        tcgv_vec_arg(v0),
        <br>
        +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
        <br>
        +        tcg_gen_or_vec(vece, v0, v0, t1);
        <br>
        +        tcg_temp_free_vec(t1);
        <br>
        +        break;
        <br>
      </blockquote>
      <br>
      And here we can use TCG_REG_V0 as the temporary, both for negation
      and shift intermediate.
      <br>
      <br>
          vrsub_vi  V0, a2, 0
      <br>
          vshlv_vv  V0, a1, V0
      <br>
          vshrv_vv  a0, a1, a2
      <br>
          vor_vv    a0, a0, V0
      <br>
      <br>
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------QG0ZpmxfaGqLM0th5Y2Baedl--

