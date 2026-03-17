Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5042BFD8764
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TwT-0008UN-6L; Tue, 17 Mar 2026 08:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w2Sl2-0003St-7A
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:38:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w2Skx-0007s7-6r
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:38:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486507134e4so6171125e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773747515; x=1774352315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHDJCqDW5sPFCzyEKLR4ACypUDaiDDIoLV/RVsztJaY=;
 b=i8W1tGKkeWmzOYIMAdPanj6M7PyHudOclkd8losi7lQkWNPP151KEEt5mfsxIPUWZc
 yWtZFjdeN5MWtYGOJ/8M4Fjt9m7RvOGUrWdBgMq7DfSd6asy6zHANuff0crX8maA+2gt
 smQ0SYehUciQbJYG796hRsjehT4XQvHPXmywyVBegwN3Kx0f8F2BAhUSSMwvB2t0vlo+
 oqEXwmTZAHvQPUr7nx3aLFqXzzNUjBtpcuAdSKU96orUGkxeoJoKzdwagApTAxGrI6nc
 apt8gycqEefEjQprlgwiAYR1ajFI/WaxF4tgVymUkRRuZu2SDgESs0ghwE2wXzpNOZJr
 07Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773747515; x=1774352315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHDJCqDW5sPFCzyEKLR4ACypUDaiDDIoLV/RVsztJaY=;
 b=VZjzjDoJjI01SIAyfhF+0SeC5HQjguLdUnCt7+U4ev46glMiACyapeSURxj8omfzvA
 GH0tD1wEMcZluBcXk8JA8wzSbIucMGfZFcJiP5WHfkcztTIoF0aCmPTUMd+9+F1HnS+s
 +QPoLQFiTN+zlqLE3fGaPBPJmu/4yZJ6Fqq/kq2Hro2SM6kOHRUZDe/CeAm9pxx8iDga
 vHkPYEUmZbCQmXscbY2cmUZHQi7YPqfI6cWZncZORPaPMWKyer2+46Tzp4kJfH3GfYXI
 wzoMdRHD2azqagyppC6kdyxlIm0W/+eMbwpPT4R20EzlPRhTjmRmk5cYFHF+2wdOXPmP
 zXjw==
X-Gm-Message-State: AOJu0YzPh+4PmRG/AeY5rWVF3EhXn891poD+k3XDlF9J50fYxjxQ3Jdd
 OAVKXSdlZMZBmx+phlW8hcmaRLcwpfB+B78k+HkYIZIvfvqRNt1hZwXyRm2FZazh
X-Gm-Gg: ATEYQzyPCJ/hRAICRBf/Td/SepDCduNIBpuO2eDY3qX9WZC2QT3OMsb6QB/1bVr7V4V
 tsDHjrvHpLKt5mOrjPlqv58PgcTCAVe2Xabr0tMYDhqI0HL62F9udVTDc7cglYC/0LID1HTsZap
 XpeOe/Hy0xY/KH7QG1PSKg6WnrbIAnGji3ANMgxrervvkcZj6uZuLy5drQkhywsQ1OBZfFjwiQh
 r5RsHXfJq+DxbLh84j0cvqST+u9l/z+BjFCOJ9VFjieeNmZ8uuvs79IxtsH0H8hgsdAmAIbvTfw
 mXbgas9sxBGPcdUs/5oiMcp/ithNx4fAsPhPKptupqz3uHt6/Uk7uxmUfmlIww3NoduTDMOZgDi
 xTRU2vdp6KPyLpRRZP1DQgZaqX2lhR4CQoEWcYOvkksv5EHISty0s/ucYMuRFioOBWZTgcf9mgh
 poaI4eEzOvF4xp+TisSQmkOGJjRXgWLuPvYR6gqhCGu0Gvuz5uqF8+3VX7H55+40aGbSa4+t05b
 KKwgQ+rYiDwgV9vtfjq
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id
 5b1f17b1804b1-485566c6a8cmr287386835e9.2.1773747514496; 
 Tue, 17 Mar 2026 04:38:34 -0700 (PDT)
Received: from DesktopTC.localdomain
 (host-87-27-45-215.business.telecomitalia.it. [87.27.45.215])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaee04fsm62721365e9.13.2026.03.17.04.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 04:38:34 -0700 (PDT)
From: Tommaso Califano <califano.tommaso@gmail.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tommaso Califano <califano.tommaso@gmail.com>
Subject: [PATCH 0/5] i386/sev: Add TCG-emulated AMD SEV guest support
Date: Tue, 17 Mar 2026 12:38:35 +0100
Message-ID: <20260317113840.33017-1-califano.tommaso@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:54:34 -0400
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

RnJvbTogVG9tbWFzbyBDYWxpZmFubyA8Y2FsaWZhbm8udG9tbWFzb0BnbWFpbC5jb20+DQoNClFF
TVUncyBBTUQgU0VWIHN1cHBvcnQgY3VycmVudGx5IHJlcXVpcmVzIEtWTSBvbiBleHBlbnNpdmUg
QU1EIEVQWUMNCmhhcmR3YXJlLCBsaW1pdGluZyBkZXZlbG9wbWVudCBhbmQgdGVzdGluZyBvZiBT
RVYtYXdhcmUgZ3Vlc3Qgc29mdHdhcmUgdG8NCnVzZXJzIHdpdGggc2VydmVyLWdyYWRlIG1hY2hp
bmVzLg0KDQpUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGEgVENHLWVtdWxhdGVkIFNFViBndWVzdCBt
b2RlIHRoYXQgZW5hYmxlcyBTRVYNCnZhbGlkYXRpb24gd2l0aG91dCBoYXJkd2FyZSBkZXBlbmRl
bmNpZXMsIGZvY3VzaW5nIG9uIGZ1bmN0aW9uYWwgdGVzdGluZw0KcmF0aGVyIHRoYW4gcmVwcm9k
dWNpbmcgdGhlIGhhcmR3YXJl4oCZcyBjcnlwdG9ncmFwaGljIGNvbnRleHQuDQoNClRoZSBlbXVs
YXRpb24gZXhwb3NlcyBTRVYgZnJvbSB0aGUgZ3Vlc3QncyBwZXJzcGVjdGl2ZToNCiAtIEV4cG9z
ZWQgQ1BVSUQgbGVhZiAweDgwMDAwMDFGIHRvIGluZGljYXRlIGFjdGl2ZSBzdXBwb3J0Lg0KIC0g
QWN0aXZlIGJpdCAwIGluIE1TUiAweGMwMDEwMTMxIHRvIGVuYWJsZSBTRVYgb24gdGhlIGd1ZXN0
Lg0KIC0gQy1iaXQgbWFuaXB1bGF0aW9uIGluIFBURXMvQ1IzIGZvciBwYWdpbmcgY29uc2lzdGVu
Y3kgd2l0aCB0aGUgaG9zdC4NCiAtIENvbXBsZXRlIFNFViBhdHRlc3RhdGlvbiB3b3JrZmxvdyBm
b3IgaW5qZWN0aW5nIHNlY3JldHMgaW50byBndWVzdA0KICAgbWVtb3J5IChpbmNsdWRpbmcgZGly
ZWN0IGtlcm5lbCBib290IHN1cHBvcnQpLg0KDQpUaGUgZW11bGF0aW9uIHVzZXMgYSBuZXcgUU9N
IG9iamVjdCAic2V2LWVtdWxhdGVkIiwgZGVyaXZlZCBmcm9tDQoic2V2LWd1ZXN0IiwgdG8gbWF4
aW1pemUgcmV1c2Ugb2YgdGhlIGV4aXN0aW5nIFNFViBpbmZyYXN0cnVjdHVyZSB3aGlsZQ0KbWFp
bnRhaW5pbmcgYSBjb21waWxpbmcgZGVwZW5kZW5jeSB3aXRoIEtWTS4NCkJlbG93IGFyZSB0aGUg
cHJvcyBhbmQgY29ucyBvZiB0aGlzIGNob2ljZS4NCg0KSW4gYWRkaXRpb24gdG8gaW5oZXJpdGVk
IGd1ZXN0IHByb3BlcnRpZXMsIHR3byBuZXcgb25lcyBhcmUgYWRkZWQgKGJpbmFyeQ0KZmlsZXM7
IGRlZmF1bHQgYWxsLXplcm8pOg0KIC0gdGlrOiAxNi1ieXRlIFRyYW5zcG9ydCBJbnRlZ3JpdHkg
S2V5IChUSUspIGZvciBtZWFzdXJlbWVudCBITUFDLg0KIC0gdGVrOiAxNi1ieXRlIFRyYW5zcG9y
dCBFbmNyeXB0aW9uIEtleSAoVEVLKSBmb3Igc2VjcmV0IHBheWxvYWQNCiAgIGRlY3J5cHRpb24u
DQoNCkNvZGUgcmV1c2UgYmVuZWZpdHM6DQogLSBTRVYgZGV0ZWN0aW9uIHZpYSBzZXZfZW5hYmxl
ZCgpIGFuZCBUWVBFX1NFVl9DT01NT04gb2JqZWN0IGNhc3QgZW5hYmxlcw0KICAgdGhlIHJlcXVp
cmVkIGNoZWNrcyBmb3IgZW11bGF0aW9uIHdpdGhvdXQgYWRkaW5nIG5ldyBjb25kaXRpb25zIHRv
IHRoZQ0KICAgY29kZWJhc2UuDQogLSBRQVBJIGZpZWxkcyBmb3IgcXVlcnktc2V2L2xhdW5jaC1t
ZWFzdXJlIGluaGVyaXRlZCBmcm9tIFNldkNvbW1vblN0YXRlDQogICBhbmQgU2V2R3Vlc3RTdGF0
ZS4NCiAtIElkZW50aWNhbCBRTVAgaW50ZXJmYWNlIChxdWVyeS1zZXYsIHF1ZXJ5LXNldi1sYXVu
Y2gtbWVhc3VyZSwNCiAgIHNldi1pbmplY3QtbGF1bmNoLXNlY3JldCkgYXMgcmVhbCBTRVYuDQog
LSBTaGFyZWQgc3RhdGUgbWFjaGluZSAoc2V2X3NldF9ndWVzdF9zdGF0ZSgpKTsgb3ZlcnJpZGUg
YmFja2VuZCB2dGFibGUNCiAgIG9ubHkgKGt2bV9pbml0IOKGkiBzZXZfZW11bGF0ZWRfaW5pdCwg
bGF1bmNoX3VwZGF0ZV9kYXRhLCBsYXVuY2hfZmluaXNoLA0KICAgc2V2X2xhdW5jaF9nZXRfbWVh
c3VyZSkuDQoNClRyYWRlLW9mZnM6DQogLSBLVk0gbGlua2FnZTogc2V2LWd1ZXN0IGlzIEtWTS1j
ZW50cmljOyBldmVuIGlmIEtWTSBpcyBub3QgdXNlZCBhdA0KICAgcnVudGltZSwgaXRzIGNvZGUg
aXMgcmVxdWlyZWQgZm9yIGNvbXBpbGF0aW9uLCBzbyBpdCBpcyBub3QgcG9zc2libGUgdG8NCiAg
IHVzZSBlbXVsYXRpb24gd2l0aCAtLWRpc2FibGUta3ZtLg0KDQpFeGFtcGxlIHVzYWdlOg0KDQoJ
LWNwdSAiRVBZQy1NaWxhbiIgXA0KCS1hY2NlbCB0Y2cgXA0KCS1vYmplY3Qgc2V2LWVtdWxhdGVk
LGlkPXNldjAsY2JpdHBvcz00NyxyZWR1Y2VkLXBoeXMtYml0cz0xLFwNCgkJdGlrPS9wYXRoL3Rv
L3Rpay5iaW4sdGVrPS9wYXRoL3RvL3Rlay5iaW4gXA0KCS1tYWNoaW5lIG1lbW9yeS1lbmNyeXB0
aW9uPXNldjANCg0KQnVpbGQgcmVxdWlyZW1lbnRzOg0KDQoJLi4vcWVtdS9jb25maWd1cmUgLS1l
bmFibGUtZ2NyeXB0IC0tZW5hYmxlLWNyeXB0by1hZmFsZw0KDQpUaGVzZSBwcm92aWRlIGxpYmdj
cnlwdCBzdXBwb3J0IGZvciBjcnlwdG8vaG1hYy5oLCBjcnlwdG8vY2lwaGVyLmgsIGFuZA0KY3J5
cHRvL3JhbmRvbS5oLCB1c2VkIGZvcjoNCiAtIEhNQUMtU0hBMjU2IGxhdW5jaCBtZWFzdXJlbWVu
dCAoVElLIGtleSkuDQogLSBTZWNyZXQgcGF5bG9hZCBkZWNyeXB0aW9uIChURUsga2V5KS4NCk5v
dGU6IC0tZGlzYWJsZS1rdm0gdW5zdXBwb3J0ZWQgZHVlIHRvIHNldi1ndWVzdCBpbmhlcml0YW5j
ZSAoS1ZNIGNvZGUNCmxpbmtlZCwgbm8gcnVudGltZSBkZXBlbmRlbmN5KS4NCg0KVG9tbWFzbyBD
YWxpZmFubyAoNSk6DQogIGkzODYvc2V2OiBBZGQgc2V2LWVtdWxhdGVkIFFPTSBvYmplY3Qgd2l0
aCBUQ0cgc3VwcG9ydA0KICB0YXJnZXQvaTM4NjogQWRkIE1TUiBTRVYgc3VwcG9ydCBhbmQgQy1i
aXQgcmVzZXQgb24gVENHDQogIGkzODYvc2V2OiBJbXBsZW1lbnQgU0VWIGxhdW5jaCBzdGF0ZSBz
ZXF1ZW5jZSBhbmQgcXVlcnktc2V2DQogIGkzODYvc2V2OiBBZGQgbGF1bmNoIG1lYXN1cmVtZW50
IGVtdWxhdGlvbiBhbmQgVElLIHByb3BlcnR5DQogIGkzODYvc2V2OiBJbXBsZW1lbnQgZW11bGF0
ZWQgbGF1bmNoIHNlY3JldCBpbmplY3Rpb24gYW5kIFRFSyBwcm9wZXJ0eQ0KDQogYWNjZWwvdGNn
L3RjZy1hbGwuYyAgICAgICAgICAgICAgICAgIHwgIDE4ICstDQogcWFwaS9xb20uanNvbiAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDE5ICsrDQogdGFyZ2V0L2kzODYvY3B1LmggICAgICAgICAg
ICAgICAgICAgIHwgICAyICsNCiB0YXJnZXQvaTM4Ni9zZXYuYyAgICAgICAgICAgICAgICAgICAg
fCA0MDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogdGFyZ2V0L2kzODYvc2V2LmggICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCiB0YXJnZXQvaTM4Ni90Y2cvc3lzdGVtL2V4Y3BfaGVs
cGVyLmMgfCAgMzEgKysNCiB0YXJnZXQvaTM4Ni90Y2cvc3lzdGVtL21pc2NfaGVscGVyLmMgfCAg
MTMgKw0KIDcgZmlsZXMgY2hhbmdlZCwgNDkwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cg0KLS0gDQoyLjUzLjANCg0K

