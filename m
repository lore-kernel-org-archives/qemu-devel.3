Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B57C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28gv-0007Ze-WC; Thu, 03 Sep 2026 10:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3138947285@qq.com>) id 1x28gr-00076g-2C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:45:21 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3138947285@qq.com>) id 1x28gn-0004X2-TU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1788446709; bh=fJ9k/dSem7YzMUR1BF3IGkKm+UaJfdZetQfHilLfjfY=;
 h=Subject:From:To:Date:In-Reply-To:References;
 b=hpyEWNqqmgK6l1jvlEzhbNrWdGsjsNbo+/CCtQ/5N2vb8yrhSRLzsMz1A0hVYVT2D
 4I+9A1WfkzVgpOLPurvtuFyPfs+aq/ayd5FgVypOrwpl404FQ06obnCLglK/RDn4/m
 P3EjAV1g5ATxIqmBNe8k4qQd12NTwULQo8jMI4nc=
Received: from Win11-9700X.localdomain
 ([240e:398:adf0:2560:dc86:1426:97f0:785b])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id B4826E9A; Thu, 03 Sep 2026 22:45:08 +0800
X-QQ-mid: xmsmtpt1788446708tjj94jw7h
Message-ID: <tencent_96F4449117E164746982AEA4983CD98B7C0A@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7VVkH6Oxzj+Ul7Cg5abdQBEE54rSqIK3ypirS3//R8j1cRVEtFl
 IGtN7dFEqHXnHZaje9xnLRcS+egucsJqqCMKG/ZOkg9RgZc/P/R8r2f5laF9ZEuRDqt12OSjyAQT
 rzzKRh2GCDb6ETQbv1QxI7xPKyEGPDWCLjINxklDMgR+mUjnXVMHNQvOL5OYNlC5wf0dGEnPKQCt
 03Gn9Jvz4fpt9CYHLwZaMd98j6L2UVw6gvMy2sBX5d9B3FCPpyksnwpNaJA9BgOFPw6lVlg+lJrh
 Sr/7HTVYCwFEF+1ftJtz8mgt81X2ILV9Y4GRPsf+wQ7n3o0xY/fKAhoN5psUxT8TAjFQtTzrae4E
 EaFFvP2SO+e/HmokpGI2v0hnojHsyYbJUCImYV/OcKqqDli6EXHSxraLVnwfaidmd0ZX/bAxYWNq
 tTR2SnB+0hH2SWwnoqxkM2JcqivXJd55DEzVbWYov7i+gOTDBlrYRP0vPdg3wtCZaLTTZuxn4494
 9n0NXGApvRO5gZ27OPURqVH04O/EB6dWxQgl7g7tDrLBQPRwVp5rn1GzV3RRhdYqm3ysugHlA7HN
 hJgCOKyDTt6Ckv1rbX20EIbzixnMTHF6m6L2W5HkxqG4Y81V1ORXqy4uLO+qrifrMq+Fe+GP1aBU
 Gm8T0R6I5C7q/L8Q4gGUC65JgTzc7xv/GwHOc7zyuNXM+3uHGflWeeNk1KY6HZHoRJiYDoKa0Rdk
 jsama8DEEiRF1hT6TJQDUj/QDIVjJ6kIU7jKTWsWQ777jMcyTBaXTR6m2wabltK8ELtQiPZJnyIL
 Ju1ySBHfE58hYLGx4yAsdwZYz79swotKNqI0X9B8OxCai4Um6vsMPPxoqGZPRbtWhP7kLvlUPRFZ
 flwxa/SqWBNABJlvUoipeyNXnNJ/IdHamyMrSylVpf9mLWAnVlIh3S+qQsyazHfrAjIoUnf4pfvH
 IfjkS2XSRo5a7zLRHluu4g1U8KhmHUw3awg2f55syxkz9HxJd1aH2LrR/disWDrW+XKx84j0SBeb
 r4agfSwLDlMUEd/0LD
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: Re: [PATCH] whpx: intercept CPUID leaf 4 so guests get the host cache
From: Jiajun Liang <3138947285@qq.com>
To: qemu-devel@nongnu.org
Date: Thu, 03 Sep 2026 22:45:07 +0800
In-Reply-To: <tencent_FA380D5D8DA060298F4F0B220D3D00E45A08@qq.com>
References: <tencent_FA380D5D8DA060298F4F0B220D3D00E45A08@qq.com>
Received-SPF: pass client-ip=162.62.57.64; envelope-from=3138947285@qq.com;
 helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksCgpHZW50bGUgcGluZyBvbiB0aGlzIHBhdGNoIChDUFVJRCBsZWFmIDQgdHJhcCBmb3IgV0hQ
WCkuIEl0IGlzIHN0aWxsIG9uCnBhdGNoZXcgYXdhaXRpbmcgcmV2aWV3OyBpcyB0aGVyZSBhbnl0
aGluZyBJIGNhbiBkbyB0byBtb3ZlIGl0IGZvcndhcmQKKHJlYmFzZSwgY29tbWl0IG1lc3NhZ2Us
IG9yIHNwbGl0dGluZyB0aGUgc2l4LWZpeCBzZXJpZXMpPwoKV2hpbGUgZGVidWdnaW5nIGZ1cnRo
ZXIgb24gdGhlIHNhbWUgV2luZG93cy9BTUQgaG9zdCBJIGlzb2xhdGVkIHR3bwptb3JlIFdIUFgg
ZGVmZWN0cyB0aGF0IGxvb2sgd29ydGggc2VuZGluZyBhcyBmb2xsb3ctdXAgcGF0Y2hlcywgYm90
aCBvZgp3aGljaCByZXByb2R1Y2UgZ3Vlc3QtdmlzaWJsZSBjb3JydXB0aW9uOgoKMS4gU3RhbGUg
WFNBVkUgaW1hZ2Ugd3JpdHRlbiBiYWNrIGludG8gSHlwZXItVi4gT24gdGhpcyBob3N0CiAgIFdI
dkdldFZpcnR1YWxQcm9jZXNzb3JTdGF0ZShYc2F2ZSkgZmFpbHMgb24gZXZlcnkgY2FsbCwgc28g
UUVNVSdzCiAgIGVudiBGUC9TU0UvQVZYIGltYWdlIGlzIG5ldmVyIHJlZnJlc2hlZDsgYW55IHZt
X3N0b3Avdm1fc3RhcnQgY3ljbGUKICAgKGdkYiBhdHRhY2gsIFFNUCBzdG9wLCBtaWdyYXRpb24g
cGF1c2UpIHRoZW4gd3JpdGVzIHRoZSBzdGFsZSBpbWFnZQogICBiYWNrIGFuZCBjbG9iYmVycyBs
aXZlIHZlY3RvciByZWdpc3RlcnMgb24gYWxsIFZQcywgY29ycnVwdGluZyB0aGUKICAgZ3Vlc3Qu
IFByb3Bvc2VkIGZpeDogdHJhY2sgeHNhdmUgdmFsaWRpdHkgcGVyIFZQIGFuZCBza2lwIHRoZQog
ICB3cml0ZS1iYWNrIHdoZW4gdGhlIHJlYWQgbmV2ZXIgc3VjY2VlZGVkLgoKMi4gTWVtb3J5QWNj
ZXNzIE1NSU8gZGlzcGF0Y2ggcnVucyB3aXRob3V0IHRoZSBCUUwuIHdocHhfdmNwdV9ydW4KICAg
ZHJvcHMgdGhlIEJRTCBiZWZvcmUgV0h2UnVuVmlydHVhbFByb2Nlc3NvciBhbmQgdGhlIE1lbW9y
eUFjY2VzcwogICBleGl0IHBhdGggbmV2ZXIgcmVhY3F1aXJlcyBpdCwgc28gZGV2aWNlIE1NSU8g
aGFuZGxlcnMgcnVuIEJRTC1mcmVlCiAgIG9uIHZDUFUgdGhyZWFkcyAoS1ZNL1RDRy9IVkYgYWxs
IGRpc3BhdGNoIE1NSU8gdW5kZXIgdGhlIEJRTCkuCiAgIERldmljZXMgdG91Y2hpbmcgTWVtb3J5
UmVnaW9uIHN0YXRlIHJhY2UgdGhlIG1haW4gbG9vcC4gUHJvcG9zZWQKICAgZml4OiB0YWtlIHRo
ZSBCUUwgYXJvdW5kIGVtdWxhdGVfaW5zdHJ1Y3Rpb24gaW4gd2hweF9oYW5kbGVfbW1pby4KCkkg
Y2FuIHBvc3QgYm90aCBhcyBwcm9wZXIgcGF0Y2hlcyBpZiB0aGV5IGFyZSBub3QgYWxyZWFkeSBr
bm93biAvCmluIGZsaWdodC4gSGFwcHkgdG8gZm9sbG93IHRoZSBwcm9qZWN0J3MgQUktY29udHJp
YnV0aW9uIHBvbGljeQpzdGF0ZW1lbnQgYXMgZGlzY3Vzc2VkLgoKVGhhbmtzLApKaWFqdW4gTGlh
bmcK


