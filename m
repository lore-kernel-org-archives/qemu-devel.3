Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA7AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scA6d-0003yI-7s; Thu, 08 Aug 2024 16:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scA6a-0003ww-QC
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 16:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scA6Z-00057r-1I
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 16:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723150285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LNCns+zn6aEQ47UCibsm/A+bcOGHaD38LiY5lj0+4L4=;
 b=a1BwYFaofQNW6hiripC/dY/A3uqfO61pnhcw0a04WCsdLESWGG/Y/UsqzbiQ9ocuf0oPZA
 9pmbq5eR0Wg0Ehp169057azWeOcYzdl8HNts1bJ429YqIWRRanpBevLMQY6YpQUVzKyfW/
 mHlIxldKnkP5IP24eXBpIjsUBNFqjIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-n6vZjH0fNSuJx-dBo3jmkg-1; Thu, 08 Aug 2024 16:51:24 -0400
X-MC-Unique: n6vZjH0fNSuJx-dBo3jmkg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-369bbbdb5a1so660870f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 13:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723150283; x=1723755083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNCns+zn6aEQ47UCibsm/A+bcOGHaD38LiY5lj0+4L4=;
 b=K4Cj5+gd6et3vDEc8p32RGAZ/O40tAUe8HksI2wsVo6qs8l7ppuKEuapyFjMNqYpOX
 RGwsZ+XMsScsXJquYnppCMDs6yO3cmphzLELwzH/ykZHQh5q/2H78ls4FTMzvrrT4MnM
 T03IzEFbdVh/FzvdujZf0jDymkX2pUm9oP/t0BU2RW6lOpRSuUWdc2qI2HfKQvowAfvl
 CbTOK1hQvugLBZ6CuGH1rfXuE/0yyDuYSPUJ9AiTWJ47b2a7HFIXTAxvpzV87XgAjWv8
 qvxOzN7wn5yoRbNPBzPPF6yHSa6nUuAqkUdgcrLH5FkTmqxbqf5uXkiQRsynYRpzwYno
 EFfA==
X-Gm-Message-State: AOJu0YybFhgrxZZHzh2K7moKkQauzFYYyYJixv4EhRoUusjU0unG57e3
 ZpDxLVFoA+Cv1CLfk3+BJNjfzxD+/X8i4EC4hZeKmXC4DcRxI6uyO+TAUeNOTkPywHj3F613/Qv
 9mgLJtbgBIt2A/+0hDnrU2DtlU2GXgdyiUzqP2DGMgd3paD2eFkDAhjsUXUFkUh3XTH79EcYSk/
 qF7bAZ4R4PXvgKJv9P+6eCydDjnck=
X-Received: by 2002:adf:cd8a:0:b0:36b:a5ac:7a with SMTP id
 ffacd0b85a97d-36d280ef138mr2504012f8f.7.1723150282690; 
 Thu, 08 Aug 2024 13:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlDiQHClH7VPzSNtFIQ15sy++Ytp6leLOLAEUlq9cI734NLjq1kpZmzJ4LVzOFExswYKodpk/5az3IOR5QkCI=
X-Received: by 2002:adf:cd8a:0:b0:36b:a5ac:7a with SMTP id
 ffacd0b85a97d-36d280ef138mr2503991f8f.7.1723150282172; 
 Thu, 08 Aug 2024 13:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240808182636.3657537-1-armbru@redhat.com>
In-Reply-To: <20240808182636.3657537-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 8 Aug 2024 16:51:09 -0400
Message-ID: <CAFn=p-bxC2wT3BX9x57dPqtsYamdstE+4fewr0LVxvbBhOUHBg@mail.gmail.com>
Subject: Re: [PATCH 0/6] qapi: Supply some of the missing member documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, jiri@resnulli.us
Content-Type: multipart/alternative; boundary="00000000000076d2e7061f323077"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000076d2e7061f323077
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:26=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> This series gets a few of modules off the pragma
> documentation-exceptions list of shame that require minimal effort.
>
> Many undocumented members still remain:
>
>     module          type or command                     #missing
>     ------------------------------------------------------------
>     audio           AudiodevDriver                      12
>     block-core      BlkdebugEvent                       43
>                     BlockdevDriver                      39
>                     BlockdevQcow2EncryptionFormat       1
>                     BlockdevVmdkAdapterType             4
>                     DummyBlockCoreForceArrays           1
>                     ImageInfoSpecificKind               2
>                     IscsiHeaderDigest                   4
>                     IscsiTransport                      2
>                     RbdAuthMode                         2
>                     RbdImageEncryptionFormat            2
>                     ThrottleGroupProperties             19
>                     XDbgBlockGraph                      2
>                     blockdev-reopen                     1
>     cryptodev       QCryptodevBackendServiceType        5
>     cxl             CxlCorErrorType                     1
>     machine-common  CpuS390Entitlement                  4
>     machine-target  CpuS390Polarization                 2
>     machine         CpuS390State                        5
>                     DummyForceArrays                    1
>                     MemoryDeviceInfoKind                1
>                     SysEmuTarget                        27
>                     X86CPURegister32                    8
>     net             NetClientDriver                     10
>                     String                              1
>     qom             ObjectType                          48
>     transaction     AbortWrapper                        1
>                     BlockDirtyBitmapAddWrapper          1
>                     BlockDirtyBitmapMergeWrapper        1
>                     BlockDirtyBitmapWrapper             1
>                     BlockdevBackupWrapper               1
>                     BlockdevSnapshotInternalWrapper     1
>                     BlockdevSnapshotSyncWrapper         1
>                     BlockdevSnapshotWrapper             1
>                     DriveBackupWrapper                  1
>     ui              DisplayProtocol                     2
>                     HotKeyMod                           3
>                     InputAxis                           2
>                     InputButton                         7
>                     KeyValueKind                        2
>                     QKeyCode                            119
>                     VncPrimaryAuth                      9
>                     VncVencryptSubAuth                  9
>     virtio          DummyVirtioForceArrays              1
>     yank            YankInstanceType                    3
>     qga             GuestNVMeSmart                      25
>
> Note: DummyVirtioForceArrays is purely internal, and should be elided
> from the manual instead, but that's a different project.
>
> Markus Armbruster (6):
>   qapi/char: Supply missing member documentation
>   qapi/common: Supply missing member documentation
>   qapi/crypto: Supply missing member documentation
>   qapi/introspect: Supply missing member documentation
>   qapi/pci: Supply missing member documentation
>   qapi/rocker: Supply missing member documentation
>
>  qapi/char.json       | 44 ++++++++++++++++++++++++++++----------------
>  qapi/common.json     | 14 +++++++++++++-
>  qapi/crypto.json     |  4 ++++
>  qapi/introspect.json | 16 ++++++++++++++++
>  qapi/pci.json        |  2 ++
>  qapi/pragma.json     |  9 +--------
>  qapi/rocker.json     |  4 ++++
>  7 files changed, 68 insertions(+), 25 deletions(-)
>
> --
> 2.45.0
>

I don't maintain any of these, but looks fine enough to me over being
undocumented.

ACK.

~~js

--00000000000076d2e7061f323077
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgQXVn
IDgsIDIwMjQgYXQgMjoyNuKAr1BNIE1hcmt1cyBBcm1icnVzdGVyICZsdDs8YSBocmVmPSJtYWls
dG86YXJtYnJ1QHJlZGhhdC5jb20iPmFybWJydUByZWRoYXQuY29tPC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij5UaGlzIHNlcmllcyBnZXRzIGEgZmV3IG9mIG1vZHVsZXMgb2ZmIHRoZSBw
cmFnbWE8YnI+DQpkb2N1bWVudGF0aW9uLWV4Y2VwdGlvbnMgbGlzdCBvZiBzaGFtZSB0aGF0IHJl
cXVpcmUgbWluaW1hbCBlZmZvcnQuPGJyPg0KPGJyPg0KTWFueSB1bmRvY3VtZW50ZWQgbWVtYmVy
cyBzdGlsbCByZW1haW46PGJyPg0KPGJyPg0KwqAgwqAgbW9kdWxlwqAgwqAgwqAgwqAgwqAgdHlw
ZSBvciBjb21tYW5kwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAjbWlzc2luZzxicj4N
CsKgIMKgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLTxicj4NCsKgIMKgIGF1ZGlvwqAgwqAgwqAgwqAgwqAgwqBBdWRpb2RldkRyaXZl
csKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDEyPGJyPg0KwqAgwqAgYmxvY2stY29y
ZcKgIMKgIMKgIEJsa2RlYnVnRXZlbnTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDQzPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQmxvY2tkZXZEcml2ZXLCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAzOTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIEJsb2NrZGV2UWNvdzJFbmNyeXB0aW9uRm9ybWF0wqAgwqAgwqAgwqAxPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQmxvY2tkZXZWbWRrQWRhcHRlclR5cGXCoCDC
oCDCoCDCoCDCoCDCoCDCoDQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEdW1t
eUJsb2NrQ29yZUZvcmNlQXJyYXlzwqAgwqAgwqAgwqAgwqAgwqAxPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgSW1hZ2VJbmZvU3BlY2lmaWNLaW5kwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSXNjc2lIZWFkZXJEaWdl
c3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBJc2NzaVRyYW5zcG9ydMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDI8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSYmRBdXRoTW9kZcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFJiZEltYWdlRW5jcnlwdGlvbkZvcm1hdMKgIMKgIMKgIMKgIMKgIMKgIDI8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUaHJvdHRsZUdyb3VwUHJvcGVydGllc8Kg
IMKgIMKgIMKgIMKgIMKgIMKgMTk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBY
RGJnQmxvY2tHcmFwaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDI8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBibG9ja2Rldi1yZW9wZW7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCBjcnlwdG9kZXbCoCDCoCDCoCDCoFFDcnlwdG9k
ZXZCYWNrZW5kU2VydmljZVR5cGXCoCDCoCDCoCDCoCA1PGJyPg0KwqAgwqAgY3hswqAgwqAgwqAg
wqAgwqAgwqAgwqBDeGxDb3JFcnJvclR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDE8YnI+DQrCoCDCoCBtYWNoaW5lLWNvbW1vbsKgIENwdVMzOTBFbnRpdGxlbWVudMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDQ8YnI+DQrCoCDCoCBtYWNoaW5lLXRhcmdldMKgIENwdVMzOTBQ
b2xhcml6YXRpb27CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDI8YnI+DQrCoCDCoCBtYWNoaW5l
wqAgwqAgwqAgwqAgwqBDcHVTMzkwU3RhdGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCA1PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRHVtbXlGb3JjZUFycmF5
c8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBNZW1vcnlEZXZpY2VJbmZvS2luZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTeXNFbXVUYXJnZXTCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAyNzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFg4NkNQVVJlZ2lzdGVyMzLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA4PGJy
Pg0KwqAgwqAgbmV0wqAgwqAgwqAgwqAgwqAgwqAgwqBOZXRDbGllbnREcml2ZXLCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDEwPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgU3RyaW5nwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTxi
cj4NCsKgIMKgIHFvbcKgIMKgIMKgIMKgIMKgIMKgIMKgT2JqZWN0VHlwZcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDQ4PGJyPg0KwqAgwqAgdHJhbnNhY3Rpb27CoCDCoCDC
oEFib3J0V3JhcHBlcsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBCbG9ja0RpcnR5Qml0bWFwQWRkV3JhcHBlcsKg
IMKgIMKgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBCbG9ja0Rp
cnR5Qml0bWFwTWVyZ2VXcmFwcGVywqAgwqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIEJsb2NrRGlydHlCaXRtYXBXcmFwcGVywqAgwqAgwqAgwqAgwqAgwqAgwqAx
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQmxvY2tkZXZCYWNrdXBXcmFwcGVy
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgQmxvY2tkZXZTbmFwc2hvdEludGVybmFsV3JhcHBlcsKgIMKgIMKgMTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIEJsb2NrZGV2U25hcHNob3RTeW5jV3JhcHBlcsKgIMKgIMKg
IMKgIMKgMTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEJsb2NrZGV2U25hcHNo
b3RXcmFwcGVywqAgwqAgwqAgwqAgwqAgwqAgwqAxPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgRHJpdmVCYWNrdXBXcmFwcGVywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTxi
cj4NCsKgIMKgIHVpwqAgwqAgwqAgwqAgwqAgwqAgwqAgRGlzcGxheVByb3RvY29swqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgSG90S2V5TW9kwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAzPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSW5wdXRBeGlzwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgSW5wdXRCdXR0b27CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDc8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBLZXlWYWx1ZUtpbmTCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgUUtleUNvZGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAx
MTk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBWbmNQcmltYXJ5QXV0aMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBWbmNWZW5jcnlwdFN1YkF1dGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA5PGJy
Pg0KwqAgwqAgdmlydGlvwqAgwqAgwqAgwqAgwqAgRHVtbXlWaXJ0aW9Gb3JjZUFycmF5c8KgIMKg
IMKgIMKgIMKgIMKgIMKgIDE8YnI+DQrCoCDCoCB5YW5rwqAgwqAgwqAgwqAgwqAgwqAgWWFua0lu
c3RhbmNlVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDM8YnI+DQrCoCDCoCBxZ2HC
oCDCoCDCoCDCoCDCoCDCoCDCoEd1ZXN0TlZNZVNtYXJ0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgMjU8YnI+DQo8YnI+DQpOb3RlOiBEdW1teVZpcnRpb0ZvcmNlQXJyYXlzIGlzIHB1
cmVseSBpbnRlcm5hbCwgYW5kIHNob3VsZCBiZSBlbGlkZWQ8YnI+DQpmcm9tIHRoZSBtYW51YWwg
aW5zdGVhZCwgYnV0IHRoYXQmIzM5O3MgYSBkaWZmZXJlbnQgcHJvamVjdC48YnI+DQo8YnI+DQpN
YXJrdXMgQXJtYnJ1c3RlciAoNik6PGJyPg0KwqAgcWFwaS9jaGFyOiBTdXBwbHkgbWlzc2luZyBt
ZW1iZXIgZG9jdW1lbnRhdGlvbjxicj4NCsKgIHFhcGkvY29tbW9uOiBTdXBwbHkgbWlzc2luZyBt
ZW1iZXIgZG9jdW1lbnRhdGlvbjxicj4NCsKgIHFhcGkvY3J5cHRvOiBTdXBwbHkgbWlzc2luZyBt
ZW1iZXIgZG9jdW1lbnRhdGlvbjxicj4NCsKgIHFhcGkvaW50cm9zcGVjdDogU3VwcGx5IG1pc3Np
bmcgbWVtYmVyIGRvY3VtZW50YXRpb248YnI+DQrCoCBxYXBpL3BjaTogU3VwcGx5IG1pc3Npbmcg
bWVtYmVyIGRvY3VtZW50YXRpb248YnI+DQrCoCBxYXBpL3JvY2tlcjogU3VwcGx5IG1pc3Npbmcg
bWVtYmVyIGRvY3VtZW50YXRpb248YnI+DQo8YnI+DQrCoHFhcGkvY2hhci5qc29uwqAgwqAgwqAg
wqB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tPGJyPg0K
wqBxYXBpL2NvbW1vbi5qc29uwqAgwqAgwqB8IDE0ICsrKysrKysrKysrKystPGJyPg0KwqBxYXBp
L2NyeXB0by5qc29uwqAgwqAgwqB8wqAgNCArKysrPGJyPg0KwqBxYXBpL2ludHJvc3BlY3QuanNv
biB8IDE2ICsrKysrKysrKysrKysrKys8YnI+DQrCoHFhcGkvcGNpLmpzb27CoCDCoCDCoCDCoCB8
wqAgMiArKzxicj4NCsKgcWFwaS9wcmFnbWEuanNvbsKgIMKgIMKgfMKgIDkgKy0tLS0tLS0tPGJy
Pg0KwqBxYXBpL3JvY2tlci5qc29uwqAgwqAgwqB8wqAgNCArKysrPGJyPg0KwqA3IGZpbGVzIGNo
YW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCi0tIDxi
cj4NCjIuNDUuMDxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGRvbiYjMzk7
dCBtYWludGFpbiBhbnkgb2YgdGhlc2UsIGJ1dCBsb29rcyBmaW5lIGVub3VnaCB0byBtZSBvdmVy
IGJlaW5nIHVuZG9jdW1lbnRlZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFDSy48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pn5+anMgPGJyPjwvZGl2PjwvZGl2PjwvZGl2Pg0K
--00000000000076d2e7061f323077--


