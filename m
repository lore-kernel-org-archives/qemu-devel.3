Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E07C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzC80-0004C6-8X; Wed, 26 Aug 2026 07:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olegendo1024@gmail.com>)
 id 1wz97V-0004mf-6o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:36:29 -0400
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <olegendo1024@gmail.com>)
 id 1wz97T-0000MV-FU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:36:28 -0400
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so261930a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787733385; x=1788338185; darn=nongnu.org;
 h=mime-version:user-agent:content-type:date:cc:to:from:subject
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FdcSQjesoz+9FYN7UW7U4CgxyPrPxdykbOJMlbgdk1s=;
 b=N9yDiEP+2KJpx5stjXwYeJBvyBqp/onv5iuJNAC0AWtcA3ctxdbSTlHo4fmQnBJyBq
 RlwNLb/KGdzkfhtBnezx8SEEGxTVmofWn9PBHFRNXt1sKKG1hJjJ2YDFMn0+eu61AX2/
 nGvz+L59OcSieuEjpHuG36FKtXgRKkXGvEeiwotqk3ElwdjvQ0INj4ZghROlXA0jB+V+
 rKLIGbh7bSWeIqrbpokloyHVnlMsEsNpnUwjFjBEwUQgoRwFaCA1yzjgX1bE8eCr7CDH
 z2yhOf+4lizQIDk3gFoAyzuLsbSF4mrqvsDHrVh0u2vMjuWmrYJoQV3yz1M4xyK0fbeJ
 BmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787733385; x=1788338185;
 h=mime-version:user-agent:content-type:date:cc:to:from:subject
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdcSQjesoz+9FYN7UW7U4CgxyPrPxdykbOJMlbgdk1s=;
 b=WVs5AZ5ZlBon94fOjeNic52+219MGaXkQ+ogSpH90BAAfzx2BLZoKlg6XV9vztdKCR
 PwqaiwG1FKMOKBdnEVLHVlrDwgX1/kNgrNtdzYOfSGlvCWZMIL1CsDd/m2d0DzN+ebBq
 IJfMGvI1rvdsUejuLy9jY4aYR4war7DKNRJTOQC3PZrpSZ+sj3e2d/6TWtZZ0oh/I5en
 jqdIC5qSItMRe1MdJj2ZHqsO2A251pYQVvNhgaFPLJ08n1M0bJ6WAYfU39tYFd+5Ahpt
 z57l6TdeFzMrgmEbyMq+pA4aJn+omh0AccWtAmmY+AUnavHd6aLCx5lXIh8+LBq936cr
 UUgw==
X-Gm-Message-State: AFuF++mivdGEJISb2oKIbwwA4Yg9H7nA1m64K+tRoUrakP0OGIGqI2Ea
 txpEhbeIFkLsD+Zkqk55ielUFTUnTcnVwdZjY4ooNTlFdFf78EYgDSkd
X-Gm-Gg: AR+sD11pnwB71c89+hDNGlj3EKl/vJdHuNcTkLyU1wZ44E1dbLJOIPQsxS3mV5/oX6z
 pizuQDouwS2xsu1kDR2fhEK5d6HIHVhf1XX1KT3VDKHA+A3OS3D9Ck2hNX6lzYsoTaegGsmFWb/
 ljjginNYPYt5ohCIRKdNkPXaJVrOcRRx2dpkJvvwON9s3wRHjDoSExEc/deWp8DqUnFk2f1Q8Kn
 3mb4tbxk4DXY0ECNoVE/2qQUg1hEtyeap6gJyxE8hKGwxksvHD6Ec1E/2MKEF0CeB0VO0BvzmFE
 QAdahIeeICFj1TzNnalM3/pDEKEaOqyyLhV63hv1mN6jY+eTPfmh7CaSOfZtNpXfijNt+QXBKC6
 ZHMPHIizNyDJera+sOLKENuRgtGiU45+VGHgMLBCVYW+MGmm+63PPKSuk2JE2dV0YI8jYiYV5FO
 7kw0gDIQtgHfQ9RcPkNeaCtiMH+EDNjacCkdeqUai6Dk2Mc25RW8zvbNqjtoMaZDSJOAkxffnvT
 qn6h9qT
X-Received: by 2002:a17:90b:1dce:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3966d3e1cfdmr10881157a91.10.1787733384914; 
 Wed, 26 Aug 2026 01:36:24 -0700 (PDT)
Received: from localhost.localdomain ([2407:c800:3620:e800:7910:9280:8105:5a2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3966875b967sm3195725a91.6.2026.08.26.01.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 01:36:23 -0700 (PDT)
Message-ID: <4a86e81ffa5e392efa069463cd21457374915b93.camel@gmail.com>
Subject: [PATCH][SH] Fix mac.w / mac.l insn
From: Oleg Endo <olegendo1024@gmail.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: qemu-devel@nongnu.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>
Date: Wed, 26 Aug 2026 17:36:22 +0900
Content-Type: multipart/mixed; boundary="=-rzUUU0xZyoVLSsBniX/I"
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:39::8;
 envelope-from=olegendo1024@gmail.com; helo=mail-pj2-x08.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2026 07:49:11 -0400
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

--=-rzUUU0xZyoVLSsBniX/I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

It seems the implementation of the mac.w / mac.l insn is wrong:

   mac.w  @Rm+,@Rn+
   mac.l  @Rm+,@Rn+

Qemu's implementation first reads both mems, then applies the post-inc. =C2=
=A0
However,

  mac.w   @R0+,@R0+

should actually do:
  read @(R0 + 0)
  R0 +=3D 2
  read @(R0 + 2)
  R0 +=3D 2

That's also how GDB sh-sim implements it.
The attached patch fixes it.

I ran into this issue recently when trying to use qemu for sh4.
I'm not on the list, so please add me in CC in the reply.

Best regards,
Oleg Endo

--=-rzUUU0xZyoVLSsBniX/I
Content-Disposition: attachment; filename="qemu-sh4-mac-same-reg.patch"
Content-Type: text/x-patch; name="qemu-sh4-mac-same-reg.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3RhcmdldC9zaDQvdHJhbnNsYXRlLmMgYi90YXJnZXQvc2g0L3RyYW5zbGF0
ZS5jCmluZGV4IDUzYjA5MjEuLmVmYmM4YWIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9zaDQvdHJhbnNs
YXRlLmMKKysrIGIvdGFyZ2V0L3NoNC90cmFuc2xhdGUuYwpAQCAtODA5LDggKzgwOSwxNyBAQCBz
dGF0aWMgdm9pZCBfZGVjb2RlX29wYyhEaXNhc0NvbnRleHQgKiBjdHgpCiAgICAgICAgICAgICB0
Y2dfZ2VuX3FlbXVfbGRfaTMyKGFyZzAsIFJFRyhCN180KSwgY3R4LT5tZW1pZHgsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1PX1RFU0wgfCBNT19BTElHTik7CiAgICAgICAgICAg
ICBhcmcxID0gdGNnX3RlbXBfbmV3KCk7Ci0gICAgICAgICAgICB0Y2dfZ2VuX3FlbXVfbGRfaTMy
KGFyZzEsIFJFRyhCMTFfOCksIGN0eC0+bWVtaWR4LAotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBNT19URVNMIHwgTU9fQUxJR04pOworICAgICAgICAgICAgaWYgKEI3XzQgPT0gQjEx
XzgpIHsKKyAgICAgICAgICAgICAgICAvKiBXaGVuIFJtIGFuZCBSbiBhcmUgdGhlIHNhbWUgcmVn
aXN0ZXIsIHRoZSBzZWNvbmQKKyAgICAgICAgICAgICAgICAgICBvcGVyYW5kIGlzIHJlYWQgYWZ0
ZXIgdGhlIGZpcnN0IHBvc3QtaW5jcmVtZW50LiAgKi8KKyAgICAgICAgICAgICAgICBUQ0d2IGFk
ZHIgPSB0Y2dfdGVtcF9uZXcoKTsKKyAgICAgICAgICAgICAgICB0Y2dfZ2VuX2FkZGlfaTMyKGFk
ZHIsIFJFRyhCMTFfOCksIDQpOworICAgICAgICAgICAgICAgIHRjZ19nZW5fcWVtdV9sZF9pMzIo
YXJnMSwgYWRkciwgY3R4LT5tZW1pZHgsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNT19URVNMIHwgTU9fQUxJR04pOworICAgICAgICAgICAgfSBlbHNlIHsKKyAgICAgICAg
ICAgICAgICB0Y2dfZ2VuX3FlbXVfbGRfaTMyKGFyZzEsIFJFRyhCMTFfOCksIGN0eC0+bWVtaWR4
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU9fVEVTTCB8IE1PX0FMSUdO
KTsKKyAgICAgICAgICAgIH0KICAgICAgICAgICAgIGdlbl9oZWxwZXJfbWFjbCh0Y2dfZW52LCBh
cmcwLCBhcmcxKTsKICAgICAgICAgICAgIHRjZ19nZW5fYWRkaV9pMzIoUkVHKEI3XzQpLCBSRUco
QjdfNCksIDQpOwogICAgICAgICAgICAgdGNnX2dlbl9hZGRpX2kzMihSRUcoQjExXzgpLCBSRUco
QjExXzgpLCA0KTsKQEAgLTgyMyw4ICs4MzIsMTYgQEAgc3RhdGljIHZvaWQgX2RlY29kZV9vcGMo
RGlzYXNDb250ZXh0ICogY3R4KQogICAgICAgICAgICAgdGNnX2dlbl9xZW11X2xkX2kzMihhcmcw
LCBSRUcoQjdfNCksIGN0eC0+bWVtaWR4LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNT19URVNXIHwgTU9fQUxJR04pOwogICAgICAgICAgICAgYXJnMSA9IHRjZ190ZW1wX25ldygp
OwotICAgICAgICAgICAgdGNnX2dlbl9xZW11X2xkX2kzMihhcmcxLCBSRUcoQjExXzgpLCBjdHgt
Pm1lbWlkeCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU9fVEVTVyB8IE1PX0FM
SUdOKTsKKyAgICAgICAgICAgIGlmIChCN180ID09IEIxMV84KSB7CisgICAgICAgICAgICAgICAg
LyogU2VlIG1hYy5sIGFib3ZlLiAgKi8KKyAgICAgICAgICAgICAgICBUQ0d2IGFkZHIgPSB0Y2df
dGVtcF9uZXcoKTsKKyAgICAgICAgICAgICAgICB0Y2dfZ2VuX2FkZGlfaTMyKGFkZHIsIFJFRyhC
MTFfOCksIDIpOworICAgICAgICAgICAgICAgIHRjZ19nZW5fcWVtdV9sZF9pMzIoYXJnMSwgYWRk
ciwgY3R4LT5tZW1pZHgsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNT19U
RVNXIHwgTU9fQUxJR04pOworICAgICAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgICAgICB0
Y2dfZ2VuX3FlbXVfbGRfaTMyKGFyZzEsIFJFRyhCMTFfOCksIGN0eC0+bWVtaWR4LAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU9fVEVTVyB8IE1PX0FMSUdOKTsKKyAgICAg
ICAgICAgIH0KICAgICAgICAgICAgIGdlbl9oZWxwZXJfbWFjdyh0Y2dfZW52LCBhcmcwLCBhcmcx
KTsKICAgICAgICAgICAgIHRjZ19nZW5fYWRkaV9pMzIoUkVHKEIxMV84KSwgUkVHKEIxMV84KSwg
Mik7CiAgICAgICAgICAgICB0Y2dfZ2VuX2FkZGlfaTMyKFJFRyhCN180KSwgUkVHKEI3XzQpLCAy
KTsK


--=-rzUUU0xZyoVLSsBniX/I--

