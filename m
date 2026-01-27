Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE6AD34093
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklLj-0003Su-Bc; Tue, 27 Jan 2026 10:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kashif04x@gmail.com>)
 id 1vklLg-0003PV-Dn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:51:24 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kashif04x@gmail.com>)
 id 1vklLe-00059t-TY
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:51:24 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-59dd490be5fso7679586e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 07:51:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769529081; cv=none;
 d=google.com; s=arc-20240605;
 b=bsC1vEkUCpesb8AcZEuK0JiOhFcgT9UHjGZOoKprlPUMM/C/H29nDVmU1KpSxFS5w4
 VimqmPlTlEQ/wJPuMb+cmfgfYdSTeo6+z2oWq0D/12TrqsFUT4i1waDVxXJUNa8q0unV
 /c5p/W3c0J4OFwUyi3FpijnTItXY60yTlOXbTkGotT0dr1kUR5p1Es0xOeO+J9CWsBcI
 1Xxe+7k4BAirpYOBQ5v0FsFkXzv0xS/pnhW8YJHLyfPPa87RHMBr6SH9OVijdXPLyw2l
 sIDA5zHuQOlmpeYSLFSQAbrrhfLcEGPruyOzZw2BiNwUE6mkF8LsBg3gbHnJWTXda0Nc
 P3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=OcqaWwwudDyJIPu3p00T9wZ67uxDgMSf37ZKnUxqgjw=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=dsiietbyF/liMVKDI42IpH7mq7t6HrEcPaGz2V6zpLNGGqiYgP7dar0+JyxF1dK5Eu
 93WfLOH3qUpkcOMB1vzSJeAFkU/aTM2idgm6pe1YYDCzttDM4rHi1QHz4meQh8MnkSco
 dyfP4AC0yS5MBr0hVDP7w3+q4sqdPTua5GZHPpTiiVqlTTjvyonEVjnQaUdzEsTfbbZ+
 x6fCjqkCFJ9anFFkjGAwBMf0d+MFNU/2Th0kQ7JEFYRoj3NliRiuVOlWNbigbJ2ED+LV
 BCkTsQ91jyIMYCvSFjUntiCSbYxG4AFbGq95VkilVjmXl3Zt9EDgPgTpXUxKFGxea6AV
 g0fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769529081; x=1770133881; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OcqaWwwudDyJIPu3p00T9wZ67uxDgMSf37ZKnUxqgjw=;
 b=JLfsPAmMFGBWC7LcsCOnjt/aT1Z3MYBWKcsn/lky4hmCb/LJq4zxT4bCjZtPG5YBMY
 UBxhGM7Z9QG43WguF5KM/fKfPP9LuvciA69r3oZTHkyg0OFbrrhITguZIH1qIOMY4M+T
 y7EQeDQ+9j7Bbu6/spJL1fnKIaaV+S77EZ87jits2nz9E+1SHxSnlorCDmKNlFsSraOV
 XAf5WVXKSX36jrFwl8aWkM9Q0cZZFm/k1yVkPwpAakAecklb/HezvufPBNzhdMRV1N+9
 hkkIi8YD2lB+gIZz7ilug7X9W10xgYOIRev4y11qurnz+l5qaAyNSEOjNNYPhM6AxJGN
 sXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769529081; x=1770133881;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OcqaWwwudDyJIPu3p00T9wZ67uxDgMSf37ZKnUxqgjw=;
 b=FvKuEH0L+ST27YN3hbkmz55CoGK/4ieWnHV139Zt1yfCWsbpGVjIy6AdQkXWEkAirh
 /JCAyFYSQHrSdEqgzG/40BtEw22TQFW73m3DfSsS87cIHNBbDGNqT6Yxzw1fPU8ezwgP
 QYVOaddh4YLD0B8Rtj1aV+pG6+sPFAQxazM9+BOFQO/IZU59Vz8EL+CNelYlT/V/UP43
 kf08QnjeDZuupBwfHY+oQZGAEUkZUfgpUabDjhDlXqBoHhSwp9fG0WGfF+xK6HUrWnfN
 xmxwnzfU8vYb1IZAbfJGYd8dhMQJSkyD4gAsmY+LpvRadJQ8pNprFu4rsIKuvtUeA+lI
 MzMQ==
X-Gm-Message-State: AOJu0YyRxORUVBMBLBiNAa+Rp20KVVSasCN8NkjDILFVvatXpXe/quYf
 9JQFLnDnHJJSGwBAV29I6Hhju9DRiX4DUeN1NmS+RASvZ+RtaNWzd7wShk43n7aTRvL1ZGL+qTr
 ueOcV3OUR1eIrOXrWMwCk21WWfy/L0Dd3H76Q
X-Gm-Gg: AZuq6aLrzP7xD2vGQtJAtmRksm5uPFwyydeHd+sYAT2Y+w51Mxg0sjRj60E+mdmF7Xu
 9C8Ac4onGwL6GJqysGCro8LouLwomvmqoBa7OBPPvLrJ6iv5bQkemXPtwH5sEBOmq0HWFYApXU4
 M118/Zw6P6AQDVXCc5VmTIU8mQeCoreFhAl7pNXY+z2i0kvFW2Dtt/CQk8AkrxUG3K1nCqJGrPA
 bnOF4WG8eJ/6MI/gGX/YRjD51S5mK+lkTSoc1vQqMQdvQ6L0jEQCmom8SYKCQpoB0BsS8S8ThTw
 cco0Lb4PZQenOgvbqr8wwSjCkKQ=
X-Received: by 2002:a05:6512:3410:b0:59e:6f4:9c55 with SMTP id
 2adb3069b0e04-59e06f49e6bmr168140e87.3.1769529080411; Tue, 27 Jan 2026
 07:51:20 -0800 (PST)
MIME-Version: 1.0
From: Mohd Kashif Khan <kashif04x@gmail.com>
Date: Tue, 27 Jan 2026 21:21:09 +0530
X-Gm-Features: AZwV_QgDYUWF66masG5G0LTItyfyO_ynLFXYtfOqq9Z6o3IKWbBEb1f-32lE-GI
Message-ID: <CACSvEXav8Gn3DL4TFMCV4nMR2BFDHT4=1Yjhq77=Eb3DryPbkQ@mail.gmail.com>
Subject: [RFC PATCH] rust: add CMSDK APB Watchdog device
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000004215b20649609893"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=kashif04x@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000004215b20649609893
Content-Type: multipart/alternative; boundary="0000000000004215b20649609891"

--0000000000004215b20649609891
Content-Type: text/plain; charset="UTF-8"

Hello,

This patch introduces a Rust implementation of the CMSDK APB Watchdog
(originally hw/watchdog/cmsdk-apb-watchdog.c).

The implementation functions as a drop-in replacement that:
1. Implements the ResettablePhasesImpl trait for hardware resets.
2. Uses BqlCell for thread-safe register access.
3. Maps the MMIO read/write logic to the Rust MemoryRegionOpsBuilder.

I welcome any feedback on the implementation or the usage of the safe
bindings.

Signed-off-by: Mohd Kashif Khan <kashif04x@gmail.com>

--0000000000004215b20649609891
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello,<br><br>This patch introduces a Rus=
t implementation of the CMSDK APB Watchdog<br>(originally hw/watchdog/cmsdk=
-apb-watchdog.c).<br><br>The implementation functions as a drop-in replacem=
ent that:<br>1. Implements the ResettablePhasesImpl trait for hardware rese=
ts.<br>2. Uses BqlCell for thread-safe register access.<br>3. Maps the MMIO=
 read/write logic to the Rust MemoryRegionOpsBuilder.<br><br>I welcome any =
feedback on the implementation or the usage of the safe bindings.<br><br>Si=
gned-off-by: Mohd Kashif Khan &lt;<a href=3D"mailto:kashif04x@gmail.com">ka=
shif04x@gmail.com</a>&gt;</div></div>

--0000000000004215b20649609891--

--0000000000004215b20649609893
Content-Type: application/octet-stream; 
	name="0001-rust-add-CMSDK-APB-Watchdog-device.patch"
Content-Disposition: attachment; 
	filename="0001-rust-add-CMSDK-APB-Watchdog-device.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mkwrvjx30>
X-Attachment-Id: f_mkwrvjx30

RnJvbSBhZGVkYmIzYjg4YzZjYzA2YzlmYTE1YzZhZTdkZjZlNjEzMGJjZDgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb2hkIEthc2hpZiBLaGFuIDxrYXNoaWYwNHhAZ21haWwuY29t
PgpEYXRlOiBUdWUsIDI3IEphbiAyMDI2IDIwOjU3OjQ0ICswNTMwClN1YmplY3Q6IFtSRkMgUEFU
Q0hdIHJ1c3Q6IGFkZCBDTVNESyBBUEIgV2F0Y2hkb2cgZGV2aWNlCgpUaGlzIHBhdGNoIGludHJv
ZHVjZXMgYSBSdXN0IGltcGxlbWVudGF0aW9uIG9mIHRoZSBDTVNESyBBUEIgV2F0Y2hkb2cKKG9y
aWdpbmFsbHkgaHcvd2F0Y2hkb2cvY21zZGstYXBiLXdhdGNoZG9nLmMpLgoKVGhlIGltcGxlbWVu
dGF0aW9uIGZ1bmN0aW9ucyBhcyBhIGRyb3AtaW4gcmVwbGFjZW1lbnQgdGhhdDoKMS4gSW1wbGVt
ZW50cyB0aGUgUmVzZXR0YWJsZVBoYXNlc0ltcGwgdHJhaXQgZm9yIGhhcmR3YXJlIHJlc2V0cy4K
Mi4gVXNlcyBCcWxDZWxsIGZvciB0aHJlYWQtc2FmZSByZWdpc3RlciBhY2Nlc3MuCjMuIE1hcHMg
dGhlIE1NSU8gcmVhZC93cml0ZSBsb2dpYyB0byB0aGUgUnVzdCBNZW1vcnlSZWdpb25PcHNCdWls
ZGVyLgoKU2lnbmVkLW9mZi1ieTogTW9oZCBLYXNoaWYgS2hhbiA8a2FzaGlmMDR4QGdtYWlsLmNv
bT4KLS0tCiBydXN0L2h3L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKwogLi4uL3dhdGNoZG9nL2Ntc2RrX2FwYl93YXRjaGRvZy9tZXNvbi5idWlsZCAgIHwgIDE5
ICsrKwogLi4uL3dhdGNoZG9nL2Ntc2RrX2FwYl93YXRjaGRvZy9zcmMvZGV2aWNlLnJzIHwgMTEw
ICsrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMzAgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHJ1c3QvaHcvd2F0Y2hkb2cvY21zZGtfYXBiX3dhdGNoZG9nL21l
c29uLmJ1aWxkCiBjcmVhdGUgbW9kZSAxMDA2NDQgcnVzdC9ody93YXRjaGRvZy9jbXNka19hcGJf
d2F0Y2hkb2cvc3JjL2RldmljZS5ycwoKZGlmZiAtLWdpdCBhL3J1c3QvaHcvbWVzb24uYnVpbGQg
Yi9ydXN0L2h3L21lc29uLmJ1aWxkCmluZGV4IDk3NDlkNGFkZmMuLmI3YzkxMmQ1YzkgMTAwNjQ0
Ci0tLSBhL3J1c3QvaHcvbWVzb24uYnVpbGQKKysrIGIvcnVzdC9ody9tZXNvbi5idWlsZApAQCAt
MSwyICsxLDMgQEAKIHN1YmRpcignY2hhcicpCiBzdWJkaXIoJ3RpbWVyJykKK3N1YmRpcignd2F0
Y2hkb2cvY21zZGtfYXBiX3dhdGNoZG9nJykKXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRp
ZmYgLS1naXQgYS9ydXN0L2h3L3dhdGNoZG9nL2Ntc2RrX2FwYl93YXRjaGRvZy9tZXNvbi5idWls
ZCBiL3J1c3QvaHcvd2F0Y2hkb2cvY21zZGtfYXBiX3dhdGNoZG9nL21lc29uLmJ1aWxkCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLjdhODZhNTM2MGEKLS0tIC9kZXYvbnVs
bAorKysgYi9ydXN0L2h3L3dhdGNoZG9nL2Ntc2RrX2FwYl93YXRjaGRvZy9tZXNvbi5idWlsZApA
QCAtMCwwICsxLDE5IEBACitfbGliX2Ntc2RrX2FwYl93YXRjaGRvZyA9IHN0YXRpY19saWJyYXJ5
KAorICAnY21zZGtfYXBiX3dhdGNoZG9nJywKKyAgZmlsZXMoJ3NyYy9kZXZpY2UucnMnKSwKKyAg
b3ZlcnJpZGVfb3B0aW9uczogWydydXN0X3N0ZD0yMDIxJywgJ2J1aWxkLnJ1c3Rfc3RkPTIwMjEn
XSwKKyAgcnVzdF9hYmk6ICdydXN0JywKKyAgbGlua193aXRoOiBbCisgICAgX3V0aWxfcnMsCisg
ICAgX2JxbF9ycywKKyAgICBfcW9tX3JzLAorICAgIF9zeXN0ZW1fcnMsCisgICAgX2h3Y29yZV9y
cywKKyAgXSwKKyAgZGVwZW5kZW5jaWVzOiBbY29tbW9uX3JzXSwKKykKKworcnVzdF9kZXZpY2Vz
X3NzLmFkZChkZWNsYXJlX2RlcGVuZGVuY3koCisgIGxpbmtfd2hvbGU6IFtfbGliX2Ntc2RrX2Fw
Yl93YXRjaGRvZ10sCisgIHZhcmlhYmxlczogeydjcmF0ZSc6ICdjbXNka19hcGJfd2F0Y2hkb2cn
fSwKKykpClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0IGEvcnVzdC9ody93
YXRjaGRvZy9jbXNka19hcGJfd2F0Y2hkb2cvc3JjL2RldmljZS5ycyBiL3J1c3QvaHcvd2F0Y2hk
b2cvY21zZGtfYXBiX3dhdGNoZG9nL3NyYy9kZXZpY2UucnMKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMC4uY2Q0ZGZjZTM2ZAotLS0gL2Rldi9udWxsCisrKyBiL3J1c3QvaHcv
d2F0Y2hkb2cvY21zZGtfYXBiX3dhdGNoZG9nL3NyYy9kZXZpY2UucnMKQEAgLTAsMCArMSwxMTAg
QEAKK3VzZSBzdGQ6OmZmaTo6Q1N0cjsKKwordXNlIGJxbDo6cHJlbHVkZTo6KjsKK3VzZSBjb21t
b246OnByZWx1ZGU6Oio7IAordXNlIGh3Y29yZTo6cHJlbHVkZTo6KjsKK3VzZSBxb206OnByZWx1
ZGU6Oio7Cit1c2Ugc3lzdGVtOjpwcmVsdWRlOjoqOworCisvLyAxLiBUeXBlIE5hbWUKK3B1YiBj
b25zdCBUWVBFX0NNU0RLX0FQQl9XQVRDSERPRzogJkNTdHIgPSBjImNtc2RrLWFwYi13YXRjaGRv
ZyI7CisKKy8vIDIuIFRoZSBTdHJ1Y3QKKyNbcmVwcihDKV0KKyNbZGVyaXZlKHFvbTo6T2JqZWN0
LCBod2NvcmU6OkRldmljZSldCitwdWIgc3RydWN0IENtc2RrQXBiV2F0Y2hkb2cgeworICAgIHBh
cmVudF9vYmo6IFBhcmVudEZpZWxkPFN5c0J1c0RldmljZT4sCisgICAgaW9tZW06IE1lbW9yeVJl
Z2lvbiwKKyAgICBjb250cm9sOiBCcWxDZWxsPHUzMj4sCisgICAgbG9hZDogICAgQnFsQ2VsbDx1
MzI+LAorICAgIHZhbHVlOiAgIEJxbENlbGw8dTMyPiwKKyAgICBsb2NrOiAgICBCcWxDZWxsPHUz
Mj4sCit9CisKKy8vIDMuIExvZ2ljIEltcGxlbWVudGF0aW9uCitpbXBsIENtc2RrQXBiV2F0Y2hk
b2cgeworICAgIGZuIHJlYWQoJnNlbGYsIG9mZnNldDogdTY0LCBfc2l6ZTogdTMyKSAtPiB1NjQg
eworICAgICAgICBtYXRjaCBvZmZzZXQgeworICAgICAgICAgICAgMHgwID0+IHNlbGYubG9hZC5n
ZXQoKSBhcyB1NjQsCisgICAgICAgICAgICAweDQgPT4gc2VsZi52YWx1ZS5nZXQoKSBhcyB1NjQs
CisgICAgICAgICAgICAweDggPT4gc2VsZi5jb250cm9sLmdldCgpIGFzIHU2NCwKKyAgICAgICAg
ICAgIDB4QzAwID0+IHNlbGYubG9jay5nZXQoKSBhcyB1NjQsCisgICAgICAgICAgICBfID0+IDAs
CisgICAgICAgIH0KKyAgICB9CisKKyAgICBmbiB3cml0ZSgmc2VsZiwgb2Zmc2V0OiB1NjQsIHZh
bHVlOiB1NjQsIF9zaXplOiB1MzIpIHsKKyAgICAgICAgaWYgc2VsZi5sb2NrLmdldCgpID09IDEg
JiYgb2Zmc2V0ICE9IDB4QzAwIHsKKyAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQorCisg
ICAgICAgIG1hdGNoIG9mZnNldCB7CisgICAgICAgICAgICAweDAgPT4gc2VsZi5sb2FkLnNldCh2
YWx1ZSBhcyB1MzIpLAorICAgICAgICAgICAgMHg0ID0+IHt9LCAKKyAgICAgICAgICAgIDB4OCA9
PiBzZWxmLmNvbnRyb2wuc2V0KHZhbHVlIGFzIHUzMiksCisgICAgICAgICAgICAweEMwMCA9PiB7
CisgICAgICAgICAgICAgICAgaWYgdmFsdWUgPT0gMHgxQUNDRTU1MSB7CisgICAgICAgICAgICAg
ICAgICAgIHNlbGYubG9jay5zZXQoMCk7CisgICAgICAgICAgICAgICAgfSBlbHNlIHsKKyAgICAg
ICAgICAgICAgICAgICAgc2VsZi5sb2NrLnNldCgxKTsKKyAgICAgICAgICAgICAgICB9CisgICAg
ICAgICAgICB9LAorICAgICAgICAgICAgXyA9PiB7fSwKKyAgICAgICAgfQorICAgIH0KKworICAg
IGZuIHJlc2V0KCZzZWxmLCBfdHlwZTogUmVzZXRUeXBlKSB7CisgICAgICAgIHNlbGYuY29udHJv
bC5zZXQoMCk7CisgICAgICAgIHNlbGYubG9hZC5zZXQoMCk7CisgICAgICAgIHNlbGYudmFsdWUu
c2V0KDApOworICAgICAgICBzZWxmLmxvY2suc2V0KDApOworICAgIH0KKworICAgIHVuc2FmZSBm
biBpbml0KG11dCB0aGlzOiBQYXJlbnRJbml0PFNlbGY+KSB7CisgICAgICAgIHN0YXRpYyBPUFM6
IE1lbW9yeVJlZ2lvbk9wczxDbXNka0FwYldhdGNoZG9nPiA9IAorICAgICAgICAgICAgTWVtb3J5
UmVnaW9uT3BzQnVpbGRlcjo6PENtc2RrQXBiV2F0Y2hkb2c+OjpuZXcoKQorICAgICAgICAgICAg
ICAgIC5yZWFkKCZDbXNka0FwYldhdGNoZG9nOjpyZWFkKQorICAgICAgICAgICAgICAgIC53cml0
ZSgmQ21zZGtBcGJXYXRjaGRvZzo6d3JpdGUpCisgICAgICAgICAgICAgICAgLmxpdHRsZV9lbmRp
YW4oKQorICAgICAgICAgICAgICAgIC5pbXBsX3NpemVzKDQsIDQpCisgICAgICAgICAgICAgICAg
LmJ1aWxkKCk7CisKKyAgICAgICAgTWVtb3J5UmVnaW9uOjppbml0X2lvKAorICAgICAgICAgICAg
Jm11dCB1bmluaXRfZmllbGRfbXV0ISgqdGhpcywgaW9tZW0pLAorICAgICAgICAgICAgJk9QUywK
KyAgICAgICAgICAgICJjbXNkay1hcGItd2F0Y2hkb2ciLAorICAgICAgICAgICAgMHgxMDAwLAor
ICAgICAgICApOworICAgICAgICAKKyAgICAgICAgdW5pbml0X2ZpZWxkX211dCEoKnRoaXMsIGNv
bnRyb2wpLndyaXRlKEJxbENlbGw6Om5ldygwKSk7CisgICAgICAgIHVuaW5pdF9maWVsZF9tdXQh
KCp0aGlzLCBsb2FkKS53cml0ZShCcWxDZWxsOjpuZXcoMCkpOworICAgICAgICB1bmluaXRfZmll
bGRfbXV0ISgqdGhpcywgdmFsdWUpLndyaXRlKEJxbENlbGw6Om5ldygwKSk7CisgICAgICAgIHVu
aW5pdF9maWVsZF9tdXQhKCp0aGlzLCBsb2NrKS53cml0ZShCcWxDZWxsOjpuZXcoMCkpOworICAg
IH0KKyAgICAKKyAgICBmbiBwb3N0X2luaXQoJnNlbGYpIHsKKyAgICAgICAgc2VsZi5pbml0X21t
aW8oJnNlbGYuaW9tZW0pOworICAgIH0KK30KKworLy8gNC4gUmVnaXN0cmF0aW9uIEdsdWUKK3Fv
bV9pc2EhKENtc2RrQXBiV2F0Y2hkb2c6IFN5c0J1c0RldmljZSwgRGV2aWNlU3RhdGUsIE9iamVj
dCk7CisKK3Vuc2FmZSBpbXBsIE9iamVjdFR5cGUgZm9yIENtc2RrQXBiV2F0Y2hkb2cgeworICAg
IHR5cGUgQ2xhc3MgPSA8U3lzQnVzRGV2aWNlIGFzIE9iamVjdFR5cGU+OjpDbGFzczsKKyAgICBj
b25zdCBUWVBFX05BTUU6ICYnc3RhdGljIENTdHIgPSBUWVBFX0NNU0RLX0FQQl9XQVRDSERPRzsK
K30KKworaW1wbCBPYmplY3RJbXBsIGZvciBDbXNka0FwYldhdGNoZG9nIHsKKyAgICB0eXBlIFBh
cmVudFR5cGUgPSBTeXNCdXNEZXZpY2U7CisgICAgY29uc3QgSU5TVEFOQ0VfSU5JVDogT3B0aW9u
PHVuc2FmZSBmbihQYXJlbnRJbml0PFNlbGY+KT4gPSBTb21lKFNlbGY6OmluaXQpOworICAgIGNv
bnN0IElOU1RBTkNFX1BPU1RfSU5JVDogT3B0aW9uPGZuKCZTZWxmKT4gPSBTb21lKFNlbGY6OnBv
c3RfaW5pdCk7CisgICAgY29uc3QgQ0xBU1NfSU5JVDogZm4oJm11dCBTZWxmOjpDbGFzcykgPSBT
ZWxmOjpDbGFzczo6Y2xhc3NfaW5pdDo6PFNlbGY+OworfQorCitpbXBsIFJlc2V0dGFibGVQaGFz
ZXNJbXBsIGZvciBDbXNka0FwYldhdGNoZG9nIHsKKyAgICBjb25zdCBIT0xEOiBPcHRpb248Zm4o
JlNlbGYsIFJlc2V0VHlwZSk+ID0gU29tZShTZWxmOjpyZXNldCk7Cit9CisKK2ltcGwgRGV2aWNl
SW1wbCBmb3IgQ21zZGtBcGJXYXRjaGRvZyB7fQoraW1wbCBTeXNCdXNEZXZpY2VJbXBsIGZvciBD
bXNka0FwYldhdGNoZG9nIHt9ClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQotLSAKMi40My4w
Cgo=
--0000000000004215b20649609893--

