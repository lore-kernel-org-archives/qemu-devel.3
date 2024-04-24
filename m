Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C41C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 11:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzaZ2-0001Vg-Fq; Wed, 24 Apr 2024 07:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzaYz-0001Ux-PY
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 07:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzaYx-0006J0-EP
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713957197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQSJHy5lU/LFhrRgSwy14AVTnbu1/FqfHiY1EbACW9w=;
 b=idb65O2ZSwGOybN11GED+skHoiLqm8jCHr7vLsCCxAqj5xEJd4wUlLAyu8COkUJlCUy6pl
 blCKYh4Z9HkkxS2bDWROKjEdppwB0W3QdZ/sYgR/OfMrOxxmiGfZTtF3OV7c4DDYkmhAuo
 vz9AQ2atzGBiNXk+2Li6rZCsDGx4ghI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-L4cFtkAAOWuM6nL4YgPFqA-1; Wed, 24 Apr 2024 07:13:14 -0400
X-MC-Unique: L4cFtkAAOWuM6nL4YgPFqA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41681022d82so32437925e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 04:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713957194; x=1714561994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQSJHy5lU/LFhrRgSwy14AVTnbu1/FqfHiY1EbACW9w=;
 b=LytS/vivTvcKFMNhf82tlIoDnEEG5du+ckLW3pkgBT5SMsRpmBnQaR8H2Z6T3Ccv99
 XtaKfFoUDg6QmYU6ratKeqYDzZunsDXikdxvookqfv2lfYhmzSQJgimPN0rdXgl37PEq
 dLAJibsF4nDwQLw0RCvEoECh9x4AXdL//ZX/7yKZmidsF7VdNbpXWJYsZ5/cxzAg//Da
 kw/twVugKVaFfZJcTb0uGcoK+mBQB1grh6w+aQyqR6iiPSEfSDq/LklHLASuMpidfbH2
 Ay87fRWdto0od1Wzgpf1nAnkcnx8IYZgcoZNuiUjB4b0R9ypJ7Cq2aCsVjNhyWMdMs4V
 vIAA==
X-Gm-Message-State: AOJu0Yz3Mqb2OzfG9TGmPkKQiFfl3O8qoM/hWP1LEthDwO3SkD3csGSf
 M2l/BMIXiJs3nVfAuL3F6vhadqCYZDFa3YukeLlVXOdvkChdbgcxKlVTQBxa2CmCj7qjmuWl7Bs
 aucZLq2FdpcaRjV1GBns43oZvRIbg1XQSSMN9U2zeDeUTUyR6KsUUeSIN0lNKtP/S8yWZssLUVJ
 KcTcwWw9JtDvoQw6ipxnyaJwOgv/Q=
X-Received: by 2002:a05:600c:1d0a:b0:417:d4f5:6501 with SMTP id
 l10-20020a05600c1d0a00b00417d4f56501mr1282510wms.27.1713957193744; 
 Wed, 24 Apr 2024 04:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnozS5LEJ4s3qXhz2SCCqfEy9Np9iJBoo/BalzmMH6doD8FS0lxrthEWXgKgXu6ggxxBSUgumxgjnF/TiMvIA=
X-Received: by 2002:a05:600c:1d0a:b0:417:d4f5:6501 with SMTP id
 l10-20020a05600c1d0a00b00417d4f56501mr1282497wms.27.1713957193348; Wed, 24
 Apr 2024 04:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
 <Zhf/czBP8LaaGORr@intel.com>
In-Reply-To: <Zhf/czBP8LaaGORr@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Apr 2024 13:13:01 +0200
Message-ID: <CABgObfYMu8sAzqJvMSQiDiY6M+uxBYc-fQadpvtoT=J=waWv4w@mail.gmail.com>
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 11, 2024 at 5:05=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> HMM, I met Guest boot failure on this patch because of ata unrecognized.
> I haven't located the exact error yet, so let me post my log first.
> If there are other means I can use to dig further, I'd be happy to try
> that too.
>
> # Command (boot a ubuntu Guest via TCG)
>
> ./qemu/build/qemu-system-x86_64 \
> -smp 1 \
> -name ubuntu -m 4G \
> -cpu max -accel tcg \
> -hda ../img_qemu/test.qcow2 -nographic \
> -kernel ../img_qemu/kernel/vmlinuz-6.4.0-rc6+ \
> -initrd ../img_qemu/kernel/initrd.img-6.4.0-rc6+ \
> -append "root=3D/dev/sda ro console=3DttyS0" \
> -qmp unix:/tmp/qmp-sock,server=3Don,wait=3Doff

The issue is that INS and OUTS are using the incorrect operand size.

While at it I also made OUTS a bit more similar to OUT:

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.=
c.inc
index 0951b042dfa..46682cfe070 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1544,8 +1544,8 @@ static const X86OpEntry opcodes_root[256] =3D {
     [0x6B] =3D X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, sextT0),
     [0x6C] =3D X86_OP_ENTRYrr(INS, Y,b, 2,w), /* DX */
     [0x6D] =3D X86_OP_ENTRYrr(INS, Y,z, 2,w), /* DX */
-    [0x6E] =3D X86_OP_ENTRYrr(OUTS, 2,w, X,b), /* DX */
-    [0x6F] =3D X86_OP_ENTRYrr(OUTS, 2,w, X,b), /* DX */
+    [0x6E] =3D X86_OP_ENTRYrr(OUTS, X,b, 2,w), /* DX */
+    [0x6F] =3D X86_OP_ENTRYrr(OUTS, X,z, 2,w), /* DX */

     [0x78] =3D X86_OP_ENTRYr(Jcc, J,b),
     [0x79] =3D X86_OP_ENTRYr(Jcc, J,b),
@@ -1592,7 +1592,7 @@ static void gen_INC(

 static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec=
ode)
 {
-    MemOp ot =3D decode->op[0].ot;
+    MemOp ot =3D decode->op[1].ot;
     TCGv_i32 port =3D tcg_temp_new_i32();

     tcg_gen_trunc_tl_i32(port, s->T1);
@@ -2310,10 +2310,10 @@ static void gen_OUT(

 static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *de=
code)
 {
-    MemOp ot =3D decode->op[2].ot;
+    MemOp ot =3D decode->op[1].ot;
     TCGv_i32 port =3D tcg_temp_new_i32();

-    tcg_gen_trunc_tl_i32(port, s->T0);
+    tcg_gen_trunc_tl_i32(port, s->T1);
     tcg_gen_ext16u_i32(port, port);
     if (!gen_check_io(s, ot, port, SVM_IOIO_STR_MASK)) {
         return;


(sorry about any word breaking)


