Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0728FCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChlA-0004Rl-4f; Fri, 02 Oct 2026 14:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xChky-0004Qi-F6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 14:13:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xChkw-0001Zw-HF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 14:13:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H6Lm62357381
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 18:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TtwM8aleJty5ZExqkZofHwVMwW51moecoMgUxfqlmWY=; b=FrL/8ODPx/hFURj5
 FfDlwuhQxpjfw3WmVgJPr5Q+xR/swVT81VHQNZboK3IvqU4n8wGZ/tlwwlxqEZQh
 fRBOjIR4Nd5Czq4ZkWhMUXtiNqmkLywjZLat3VaNJpxc5HWQBBHFUhOYJnRFriwK
 AJe7zwuBiQ1uaj2CXoIPkawYuLU1rkeg3w7kqOqcWUEgZm6qj+aemhGRs1nZGwgU
 3NQuLLYB/DWF2dZFoVfQ3ujV73gH6hVKAN7Y2gFHdIuG0LeoMRt5/rRrG6v3LWcC
 awcWmA/s2AYID1RItaxY9mXb9r7xxSLUG/VGjxq2dMNl1GFbRFbOI2ZHCHf5BdvT
 j8wXIQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh3n9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 18:13:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so156741301cf.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790964792; x=1791569592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TtwM8aleJty5ZExqkZofHwVMwW51moecoMgUxfqlmWY=;
 b=MOFhbaFuK1U5ElH03Q19XJBNmCEipIYmQYoqTh7FCdJnm4eKUTko6heyvQWu0maYZ4
 aKBiYmKcPEUu9h5v9NUA60/neqjGcFiR8c/oDSPqtb8VfTETDCelluSo72axfXXhqLnu
 5Ds2kiAt0Yx4gBOEfUXbNCwui+79Ad6EPOJp+K/LbJigZLah9TmI8AUpGSqBSid/DMTM
 WQ3huTn+sLmABvopD3UzptyOsbsVjh1kO9CpMnEF8bqOlceT3d1BMqqBtVvQGUCcE3f/
 MRXna2A0kW+df9eqb3Uz1Dj4a9aiRZ8BFRaXZqD3oIPxWk5N5lM6Z//EZqVu3IrtafMI
 rSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790964792; x=1791569592;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TtwM8aleJty5ZExqkZofHwVMwW51moecoMgUxfqlmWY=;
 b=QQKvErQthoyBQPfs7Qo6luAhwe7tcq3e5YlEDpr1Dq1nyoTTEbL+UKxqWk7hDLPc4E
 XZ9YcPVvWaQ+6QABhRqhPdJofywdzEtFiYTaYsNQhlGa/Ha5BmQGo90qdQEsC7Q9b7a6
 6rLXqwitN7SZIFRw80pLDagHlDvp96+hdR/QVYJzPquD/ysEsbHuXbIshZJ84RqMS++y
 7NorBGp19X+PzORF9iQG4mgLSa4H34wa6O2KRFyFymgP56yQxo3nvK8DWWEx1EuwJe0V
 hSbWHZZbh7dFCZFCChiPATicv796T5PUARm5/PNgvsY5BDw8cK32e01j92ctOOgTFvAK
 DFGg==
X-Gm-Message-State: AFuF++kWNa741tKKbucJ05MFgGYxs3qOREl19Q3ViO7HCqrBLYrOkiFq
 sND637sDTKOeNozebidwg4l38hCtwYstaKcSiZ9J6qaNzqz7YohpWbwKD5TsyXhYiceJi0Uf4Zz
 0zldCcONO0LeOoScW6bhVqW3JFz8QtcUJHZUnZ9nS/iwU5lGjfmkgIY3+bg==
X-Gm-Gg: AYBFou34YNuLQT/WSioOt6ribtPSfFQQcV2Yratnpz5BQwS6cKYMMd15//KrasyIwW/
 IMGcM91zZW/q26U8x4B7WPy/Eb7XY/hPqvOXFZVS1p/4ZTs8dK/wVh2pANVkUf65w9qwOEQMLfK
 NdXJ3I7cIZcKqoopNBi2dMzfVx76S0G+tQh4T7W2gAWImv5kZiJD4HM+kWfZ31IXHesihRwHvw1
 BYORIbxUnFoP4xEtCIOPoPlV/zq4CSLEtGnYJIjdWcVIJbDZ7CIOml+JAMwUjnKHb/jlcxXG9El
 EiOeAeH2ZwHFlhKCCQ27u50ukljMWGmgud7iBPwgKu9wZ7IHlNthe86CJ1WIstkjzYA2y9nJDoh
 Ed6F+kHAH31omGPbGQJI8SnShvaTcvsgw7OLsMChhf1L+BMweFayWYyey6W6g04cB
X-Received: by 2002:a05:622a:1b1e:b0:535:981:7851 with SMTP id
 d75a77b69052e-535098186edmr31540191cf.56.1790964791864; 
 Fri, 02 Oct 2026 11:13:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1b1e:b0:535:981:7851 with SMTP id
 d75a77b69052e-535098186edmr31539301cf.56.1790964791151; 
 Fri, 02 Oct 2026 11:13:11 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398a9c92csm33490921cf.11.2026.10.02.11.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 11:13:10 -0700 (PDT)
Message-ID: <9e914efb-c4c3-4860-8ed5-8a4046e0ca01@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 13:13:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/hexagon: reserve internal HVX vector state
 for QFloat
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-7-brian.cain@oss.qualcomm.com>
 <CAJ+KCYP4jViUrM0M-EktGgDj=wHaK-vnmBZ1dOfJzhH7KZjF=w@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYP4jViUrM0M-EktGgDj=wHaK-vnmBZ1dOfJzhH7KZjF=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MiBTYWx0ZWRfX54vmYRnTH9Sd
 rq1/9g2pDcdCzOqmJrwnr3gzu4h/1eKfsIEbYCVGNi5XesFEWWbL+tBc6H3CqU3mVr84eXG7UXV
 +1sPTWefGwh1ASWCghodX2oQqI1h5wA=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abff438 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FttlZHXPmNnUGXYr6mEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MiBTYWx0ZWRfX3D+jkCO6jMCI
 wEK81s1sCT0CB4lWBQIJbVzfsFznGURE3xAHdxm8xMXbnOqCfJFHXzdJYCqWzR5vAVe5nCricaX
 lz8H2q5caWBoiQh9nW6XjbYNJHM/81M+e5Gl3ywHLZkfSG+ZXTMPppwaEX+56WLlI+aflWDixdI
 5Jclfr80JS6qP8BlNV5G451VfY8TyYHIj2d8awoaVHNt/6+JOE+6e/oiXrILAkcNYwpr1zDPIGd
 FsfW+/Sla3zFWwzcTsdlKDarE1GRG/iY38VIhtQc60EVxRfji6EyhpXLc3iqf7HuGK/Miagz8y9
 CWNlqwR6ueeaJxZlGoraf4+cdoY0jfQXAHmu72r4Ah0jSol6q0iv7bv05z8C+72LZ+ge9rdtnVF
 NozqI53bCkiHai7KP/aNhZCx4yhPCwrC5XspKYAHcONtOLTkzD9u9Ol4s0uLhGcDlEg2llrPESh
 1r9RydXc8V4auJ+yqEA==
X-Proofpoint-GUID: YbMykLILXtpxiAKD9V_3lUiHBUvIKUXg
X-Proofpoint-ORIG-GUID: YbMykLILXtpxiAKD9V_3lUiHBUvIKUXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/30/2026 1:19 PM, Marco Liebel wrote:
> On Sat, Sep 26, 2026 at 2:23 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/mmvec/mmvec.h     | 55 ++++++++++++++++++++------------
>>   hw/hexagon/hexagon_hvx_context.c |  5 +++
>>   target/hexagon/hex_common.py     | 29 +++++++++++++++++
>>   3 files changed, 68 insertions(+), 21 deletions(-)
>>
>> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>> index 02c54506145..55b8a40fe8c 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -448,6 +448,25 @@ def helper_arg_type(self):
>>           return "void *"
>>       def helper_arg_name(self):
>>           return f"{self.reg_tcg()}_void"
>> +    def gen_clear_ext(self, f):
>> +        f.write(code_fmt(f"""\
>> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
>> +                    {self.hvx_off()} + offsetof(MMVector, ext),
>> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
>> +                    V_EXTENDED_BYTEVAL);
>> +            """))
>> +    def gen_clear_ext_pair(self, f):
>> +        f.write(code_fmt(f"""\
>> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
>> +                    {self.hvx_off()} + offsetof(MMVector, ext),
>> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
>> +                    V_EXTENDED_BYTEVAL);
>> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
>> +                    {self.hvx_off()} + sizeof(MMVector)
>> +                        + offsetof(MMVector, ext),
>> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
>> +                    V_EXTENDED_BYTEVAL);
>> +            """))
>>
> gen_clear_ext() and gen_clear_ext_pair() currently update the
> destination vector’s
> extension field even when the instruction predicate is false. The following test
> demonstrates the issue:


Thanks for the fix and the test!  Will address them.


>
> static void test_ext_bits_preserved_on_false_predicate(void)
> {
>      asm volatile(
>          "r0 = #0x11111111\n"
>          "v3 = vsplat(r0)\n"
>          "v0.x = vsetqfext(v3, r0)\n"
>          "r2 = #1\n"
>          "v1 = vsplat(r2)\n"
>          "r1 = #0\n"
>          "p0 = cmp.eq(r1, r2)\n"
>          "{\n"
>          "    if (p0) v0 = v1\n"
>          "}\n"
>          "v2 = vgetqfext(v0.x, r0)\n"
>          "vmemu(%[out]) = v2\n"
>          :
>          : [out] "r"(output)
>          : "r0", "r1", "r2", "v0", "v1", "v2", "v3", "p0", "memory");
>
>      for (int i = 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
>          expect[0].uw[i] = 0x11111111;
>      }
>
>      check_output_w(__LINE__, 1);
> }
>
> The extension reset needs to be predicated as well. For example:
>
> def gen_clear_ext(self, f, tag):
>      predicate = None
>      guard = ""
>      if is_predicated(tag):
>          for regtype, regid in compute_tag_regs(tag, False):
>              if regtype == "P":
>                  predicate = get_register(tag, regtype, regid).reg_tcg()
>                  break
>          assert predicate is not None
>          cond = "TCG_COND_NE" if "fLSBOLDNOT" in semdict[tag] else "TCG_COND_EQ"
>          guard = f"""
>              TCGv {self.reg_tcg()}_ext_pred = tcg_temp_new();
>              TCGLabel *{self.reg_tcg()}_ext_skip = gen_new_label();
>              tcg_gen_andi_tl({self.reg_tcg()}_ext_pred, {predicate}, 1);
>              tcg_gen_brcondi_tl({cond}, {self.reg_tcg()}_ext_pred, 0,
>                                  {self.reg_tcg()}_ext_skip);
>          """
>          end_guard = f"""
>              gen_set_label({self.reg_tcg()}_ext_skip);
>          """
>      else:
>          end_guard = ""
>      f.write(code_fmt(f"""\
>              {guard}
>              tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
>                  {self.hvx_off()} + offsetof(MMVector, ext),
>                  MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
>                  V_EXTENDED_BYTEVAL);
>              {end_guard}
>          """))
>
> def gen_clear_ext_pair(self, f, tag):
>      predicate = None
>      guard = ""
>      if is_predicated(tag):
>          for regtype, regid in compute_tag_regs(tag, False):
>              if regtype == "P":
>                  predicate = get_register(tag, regtype, regid).reg_tcg()
>                  break
>          assert predicate is not None
>          cond = "TCG_COND_NE" if "fLSBOLDNOT" in semdict[tag] else "TCG_COND_EQ"
>          guard = f"""
>              TCGv {self.reg_tcg()}_ext_pred = tcg_temp_new();
>              TCGLabel *{self.reg_tcg()}_ext_skip = gen_new_label();
>              tcg_gen_andi_tl({self.reg_tcg()}_ext_pred, {predicate}, 1);
>              tcg_gen_brcondi_tl({cond}, {self.reg_tcg()}_ext_pred, 0,
>                                  {self.reg_tcg()}_ext_skip);
>          """
>          end_guard = f"""
>              gen_set_label({self.reg_tcg()}_ext_skip);
>          """
>      else:
>          end_guard = ""
>      f.write(code_fmt(f"""\
>              {guard}
>              tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
>                  {self.hvx_off()} + offsetof(MMVector, ext),
>                  MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
>                  V_EXTENDED_BYTEVAL);
>              tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
>                  {self.hvx_off()} + sizeof(MMVector)
>                      + offsetof(MMVector, ext),
>                  MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
>                  V_EXTENDED_BYTEVAL);
>              {end_guard}
>          """))

