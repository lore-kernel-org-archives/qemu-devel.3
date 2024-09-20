Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561FC78853
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 14:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srecX-0008EG-2R; Fri, 20 Sep 2024 10:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1srecO-0008Cx-9d; Fri, 20 Sep 2024 10:28:20 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1srecK-0006Qt-4i; Fri, 20 Sep 2024 10:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726842483; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=4+Z1zB86W08EFswS88V1tEOdDVh9ogt/XoR/HKLOluE=;
 b=KcWrpncWPcMGON4QhfhqqP0uPQReh3Q96F5KCUYAN4wc5/w81KcjkQJ6s78hTpGSRoHWENjRlH803OxL+4tXuUHSGfWV+P+4avgv/C5+Yi2CrDzjB8QtEDlgHJIhxBzNdEpc38jLRUUcPOqIe8WTztMichIpknyRVe1yyWPgrt0=
Received: from 192.168.3.95(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WFLKmIh_1726842477) by smtp.aliyun-inc.com;
 Fri, 20 Sep 2024 22:27:58 +0800
Content-Type: multipart/alternative;
 boundary="------------GcLzkqPsHQyKeZ4EltwQppKH"
Message-ID: <a7973dea-a430-473f-b0e9-c85fdeda1ac3@linux.alibaba.com>
Date: Fri, 20 Sep 2024 22:26:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
To: 0x48 Swung <swung0x48@outlook.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-3-zhiwei_liu@linux.alibaba.com>
 <0d591570-02c6-48c9-9e3f-ef47ac20ce7d@linaro.org>
 <b87e7a7e-41fd-4b26-bde3-9adca9babb24@linux.alibaba.com>
 <33101e38-080d-4444-a8c3-9d01827e243f@linaro.org>
 <b88244bc-aaf7-42f9-a90f-e4027ac72ebf@linux.alibaba.com>
 <20e20fde-830f-4314-a944-e7973bda5d8c@linaro.org>
 <SY8P300MB02825DF878585DDC68EB088CE06C2@SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <SY8P300MB02825DF878585DDC68EB088CE06C2@SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM>
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
--------------GcLzkqPsHQyKeZ4EltwQppKH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/9/20 12:01, 0x48 Swung wrote:
> Hey everyone! Late to the party. Life happens sometimes ;)
> Just discovered this patch and this mail list, and I'd like to provide 
> some background story here.
> I originally provided my initial implementation in a downstream repo 
> last year, namely 
> https://github.com/plctlab/plct-qemu/tree/plct-riscv-backend-rvv .
> I'm new to contributing to qemu and also take part in the open-source 
> community upstreaming process as a whole, so I may make mistakes in my 
> following claims, but I see some confusion here:
> 1. The PLCT branch (which includes my original commits) is 
> open-sourced using GPLv2, which follows QEMU's upstream repo. So 
> according to the license, my modification should be EXPLICITLY shown 
> in the patch, but I haven't seen any.
> 2. I do consent upstreaming my patch last year, in the form of a patch 
> submitted with modifications from T-head, and on behalf of them. And 
> it was agreed back in the days that I can be mentioned as one of the 
> authors. But it turnsout that there's no "sign-off", "author", 
> "co-author" line mentioning me. If I don't speak out in this 
> situation, does it imply that this patch is purely LIU Zhiwei's work 
> and have nothing to do with me?
>
> I'd like LIU to separate my patch and his modification to two separate 
> patches, and explicitly name where are those patches coming from, so 
> that this patch can comply to GPLv2 license and can we clarify those 
> misunderstandings.
>
> I don't want to take it personally , but I do smell something's wrong 
> going on here...

I think there was a misunderstanding. But I will not explain it too much 
here. If you agree, please don't block this work and send the tag as 
Daniel and Markus point out.

Thanks,
Zhiwei

>
> Best Regards,
> Swung0x48 (aka. Huang Shiyuan)
>
> Get Outlook for Android <https://aka.ms/AAb9ysg>
> ------------------------------------------------------------------------
> *From:* Richard Henderson <richard.henderson@linaro.org>
> *Sent:* Wednesday, September 18, 2024 10:27:16 PM
> *To:* LIU Zhiwei <zhiwei_liu@linux.alibaba.com>; qemu-devel@nongnu.org 
> <qemu-devel@nongnu.org>
> *Cc:* qemu-riscv@nongnu.org <qemu-riscv@nongnu.org>; 
> palmer@dabbelt.com <palmer@dabbelt.com>; alistair.francis@wdc.com 
> <alistair.francis@wdc.com>; dbarboza@ventanamicro.com 
> <dbarboza@ventanamicro.com>; liwei1518@gmail.com 
> <liwei1518@gmail.com>; bmeng.cn@gmail.com <bmeng.cn@gmail.com>; 
> Swung0x48 <swung0x48@outlook.com>; TANG Tiancheng 
> <tangtiancheng.ttc@alibaba-inc.com>
> *Subject:* Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
> On 9/18/24 12:43, LIU Zhiwei wrote:
> >
> > On 2024/9/18 18:11, Richard Henderson wrote:
> >> On 9/18/24 07:17, LIU Zhiwei wrote:
> >>>
> >>> On 2024/9/12 2:41, Richard Henderson wrote:
> >>>> On 9/11/24 06:26, LIU Zhiwei wrote:
> >>>>> From: Swung0x48<swung0x48@outlook.com>
> >>>>>
> >>>>> The RISC-V vector instruction set utilizes the LMUL field to group
> >>>>> multiple registers, enabling variable-length vector registers. This
> >>>>> implementation uses only the first register number of each group 
> while
> >>>>> reserving the other register numbers within the group.
> >>>>>
> >>>>> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
> >>>>> host runtime needs to adjust LMUL based on the type to use different
> >>>>> register groups.
> >>>>>
> >>>>> This presents challenges for TCG's register allocation. 
> Currently, we
> >>>>> avoid modifying the register allocation part of TCG and only 
> expose the
> >>>>> minimum number of vector registers.
> >>>>>
> >>>>> For example, when the host vlen is 64 bits and type is 
> TCG_TYPE_V256, with
> >>>>> LMUL equal to 4, we use 4 vector registers as one register 
> group. We can
> >>>>> use a maximum of 8 register groups, but the V0 register number 
> is reserved
> >>>>> as a mask register, so we can effectively use at most 7 register 
> groups.
> >>>>> Moreover, when type is smaller than TCG_TYPE_V256, only 7 
> registers are
> >>>>> forced to be used. This is because TCG cannot yet dynamically 
> constrain
> >>>>> registers with type; likewise, when the host vlen is 128 bits and
> >>>>> TCG_TYPE_V256, we can use at most 15 registers.
> >>>>>
> >>>>> There is not much pressure on vector register allocation in TCG 
> now, so
> >>>>> using 7 registers is feasible and will not have a major impact 
> on code
> >>>>> generation.
> >>>>>
> >>>>> This patch:
> >>>>> 1. Reserves vector register 0 for use as a mask register.
> >>>>> 2. When using register groups, reserves the additional registers 
> within
> >>>>>     each group.
> >>>>>
> >>>>> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> >>>>> Co-authored-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> >>>>
> >>>> If there is a co-author, there should be another Signed-off-by.
> >>>
> >>> This patch has added a tag:
> >>>
> >>> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> >>>
> >>>
> >>> Do you mean we should add the same tag twice?
> >>
> >> The from line is "Swung0x48 <swung0x48@outlook.com>".
> >> If this is an alternate email for TANG Tiancheng,
> >
> > No, Swung0x48 is another author.
>
> Then we need a proper Signed-off-by line from that author.
>
>
> r~
--------------GcLzkqPsHQyKeZ4EltwQppKH
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
    <div class="moz-cite-prefix">On 2024/9/20 12:01, 0x48 Swung wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:SY8P300MB02825DF878585DDC68EB088CE06C2@SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="auto">Hey ever<span>yone! Late to the <span>party. Life
            happens sometimes ;)</span></span></div>
      <div dir="auto"><span><span>Just discovered this patch and this
            mail list, and I'd like to provide some back<span>ground
              story here.</span></span></span></div>
      <div dir="auto">I originally provided my initial implementation in
        a downstream repo last year, namely <a rel="noreferrer noopener"
href="https://github.com/plctlab/plct-qemu/tree/plct-riscv-backend-rvv"
style="font-family: sans-serif; font-size: medium; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; color: rgb(0, 120, 212); background-color: rgb(255, 255, 255);"
          moz-do-not-send="true" class="moz-txt-link-freetext">https://github.com/plctlab/plct-qemu/tree/plct-riscv-backend-rvv</a> .</div>
      <div dir="auto">I'm new to contributing to qemu and also take part
        in the open-source community upstreaming process as a whole, so
        I may make mistakes in my following claims, but I see some
        confusion here:</div>
      <div dir="auto">1. The PLCT branch (which includes my original
        commits) is open-sourced using GPLv2, which follows QEMU's
        upstream repo. So acc<span>ording to the license, my
          modification should be EXPLICITLY shown in the patch, but I
          haven't seen any.</span></div>
      <div dir="auto"><span>2. I do consent upstreaming my patch last
          year, in the form of a patch submitted with modifications from
          T-head, and on behalf of them. And it was agreed back in the
          days that I can be mentioned as one of the authors. But it
          turns<span> out that there's no "sign-off", "author",
            "co-author" line mentioning me. If I don't speak out in this
            situ<span>ation, does it imply that this patch is purely LIU
              Zhiwei's work and have nothing to <span>do with me?</span></span></span></span></div>
      <div dir="auto"><span><span><span><span><br>
              </span></span></span></span></div>
      <div dir="auto"><span><span><span><span>I'd like LIU to separate
                my patch and his modifi<span>cation to two separate
                  patches, and explicitly name where are tho<span>se
                    patches com<span>ing from, so that this patch can
                      comply to GPLv2 license and can we clarify those
                      misun<span>derstandings.</span></span></span></span></span></span></span></span></div>
      <div dir="auto"><span><span><span><span><br>
              </span></span></span></span></div>
      <div dir="auto"><span><span><span><span>I don't want to take it <span>personally
                  , but I do smell something's wrong going on here...</span></span></span></span></span></div>
    </blockquote>
    <p>I think there was a misunderstanding. But I will not explain it
      too much here. If you agree, please don't block this work and send
      the tag as Daniel and Markus point out.</p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <blockquote type="cite"
cite="mid:SY8P300MB02825DF878585DDC68EB088CE06C2@SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM">
      <div dir="auto"><span><span><span><span><span><br>
                </span></span></span></span></span></div>
      <div dir="auto"><span><span><span><span><span>Best Rega<span>rds,</span></span></span></span></span></span></div>
      <div dir="auto"><span><span><span><span><span><span>Swung0x48
                    (aka. Huang Shiyuan)</span></span></span></span></span></span></div>
      <div><br>
      </div>
      <div id="ms-outlook-mobile-signature" dir="auto">Get <a
          href="https://aka.ms/AAb9ysg" moz-do-not-send="true">
          Outlook for Android</a></div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a><br>
          <b>Sent:</b> Wednesday, September 18, 2024 10:27:16 PM<br>
          <b>To:</b> LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:qemu-devel@nongnu.org">&lt;qemu-devel@nongnu.org&gt;</a><br>
          <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:qemu-riscv@nongnu.org">qemu-riscv@nongnu.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:qemu-riscv@nongnu.org">&lt;qemu-riscv@nongnu.org&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:palmer@dabbelt.com">palmer@dabbelt.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:palmer@dabbelt.com">&lt;palmer@dabbelt.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:alistair.francis@wdc.com">alistair.francis@wdc.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com">&lt;dbarboza@ventanamicro.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:liwei1518@gmail.com">liwei1518@gmail.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:liwei1518@gmail.com">&lt;liwei1518@gmail.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:bmeng.cn@gmail.com">bmeng.cn@gmail.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:bmeng.cn@gmail.com">&lt;bmeng.cn@gmail.com&gt;</a>; Swung0x48
          <a class="moz-txt-link-rfc2396E" href="mailto:swung0x48@outlook.com">&lt;swung0x48@outlook.com&gt;</a>; TANG Tiancheng
          <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH v4 02/12] tcg/riscv: Add basic
          support for vector</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">On 9/18/24 12:43, LIU Zhiwei wrote:<br>
              &gt; <br>
              &gt; On 2024/9/18 18:11, Richard Henderson wrote:<br>
              &gt;&gt; On 9/18/24 07:17, LIU Zhiwei wrote:<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; On 2024/9/12 2:41, Richard Henderson wrote:<br>
              &gt;&gt;&gt;&gt; On 9/11/24 06:26, LIU Zhiwei wrote:<br>
              &gt;&gt;&gt;&gt;&gt; From:
              Swung0x48<a class="moz-txt-link-rfc2396E" href="mailto:swung0x48@outlook.com">&lt;swung0x48@outlook.com&gt;</a><br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; The RISC-V vector instruction set
              utilizes the LMUL field to group<br>
              &gt;&gt;&gt;&gt;&gt; multiple registers, enabling
              variable-length vector registers. This<br>
              &gt;&gt;&gt;&gt;&gt; implementation uses only the first
              register number of each group while<br>
              &gt;&gt;&gt;&gt;&gt; reserving the other register numbers
              within the group.<br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; In TCG, each VEC_IR can have 3 types
              (TCG_TYPE_V64/128/256), and the<br>
              &gt;&gt;&gt;&gt;&gt; host runtime needs to adjust LMUL
              based on the type to use different<br>
              &gt;&gt;&gt;&gt;&gt; register groups.<br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; This presents challenges for TCG's
              register allocation. Currently, we<br>
              &gt;&gt;&gt;&gt;&gt; avoid modifying the register
              allocation part of TCG and only expose the<br>
              &gt;&gt;&gt;&gt;&gt; minimum number of vector registers.<br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; For example, when the host vlen is 64
              bits and type is TCG_TYPE_V256, with<br>
              &gt;&gt;&gt;&gt;&gt; LMUL equal to 4, we use 4 vector
              registers as one register group. We can<br>
              &gt;&gt;&gt;&gt;&gt; use a maximum of 8 register groups,
              but the V0 register number is reserved<br>
              &gt;&gt;&gt;&gt;&gt; as a mask register, so we can
              effectively use at most 7 register groups.<br>
              &gt;&gt;&gt;&gt;&gt; Moreover, when type is smaller than
              TCG_TYPE_V256, only 7 registers are<br>
              &gt;&gt;&gt;&gt;&gt; forced to be used. This is because
              TCG cannot yet dynamically constrain<br>
              &gt;&gt;&gt;&gt;&gt; registers with type; likewise, when
              the host vlen is 128 bits and<br>
              &gt;&gt;&gt;&gt;&gt; TCG_TYPE_V256, we can use at most 15
              registers.<br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; There is not much pressure on vector
              register allocation in TCG now, so<br>
              &gt;&gt;&gt;&gt;&gt; using 7 registers is feasible and
              will not have a major impact on code<br>
              &gt;&gt;&gt;&gt;&gt; generation.<br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; This patch:<br>
              &gt;&gt;&gt;&gt;&gt; 1. Reserves vector register 0 for use
              as a mask register.<br>
              &gt;&gt;&gt;&gt;&gt; 2. When using register groups,
              reserves the additional registers within<br>
              &gt;&gt;&gt;&gt;&gt;     each group.<br>
              &gt;&gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt;&gt; Signed-off-by: TANG
              Tiancheng<a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a><br>
              &gt;&gt;&gt;&gt;&gt; Co-authored-by: TANG
              Tiancheng<a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a><br>
              &gt;&gt;&gt;&gt;<br>
              &gt;&gt;&gt;&gt; If there is a co-author, there should be
              another Signed-off-by.<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; This patch has added a tag:<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; Signed-off-by: TANG
              Tiancheng<a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a><br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; Do you mean we should add the same tag twice?<br>
              &gt;&gt;<br>
              &gt;&gt; The from line is "Swung0x48
              <a class="moz-txt-link-rfc2396E" href="mailto:swung0x48@outlook.com">&lt;swung0x48@outlook.com&gt;</a>".<br>
              &gt;&gt; If this is an alternate email for TANG Tiancheng,<br>
              &gt; <br>
              &gt; No, Swung0x48 is another author.<br>
              <br>
              Then we need a proper Signed-off-by line from that author.<br>
              <br>
              <br>
              r~<br>
            </div>
          </span></font></div>
    </blockquote>
  </body>
</html>

--------------GcLzkqPsHQyKeZ4EltwQppKH--

