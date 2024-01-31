Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A2C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9RO-0002gT-VN; Wed, 31 Jan 2024 07:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhw2101024@gmail.com>)
 id 1rV5iY-0002MS-IB; Wed, 31 Jan 2024 03:13:10 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhw2101024@gmail.com>)
 id 1rV5iT-0007ZW-LY; Wed, 31 Jan 2024 03:13:10 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42a8a3973c5so34995471cf.2; 
 Wed, 31 Jan 2024 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706688783; x=1707293583; darn=nongnu.org;
 h=subject:cc:from:to:content-language:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tfvqDFWTPL3MkyynuCtvPHgsOFdtZK9xcaIxW9NzxDI=;
 b=jaFPg8VC7mEm3zWHCQUVgbu4vVZJkopKjJnTScLIJr6OFyKNcPa/rf0pTq0dHsfJJe
 MSql2Oo1TXZU8snRDKRdmQgYRB/LN9WbA1NXJZTR5LtuXG4DIiYfO6TqgG7bxuUx88LH
 cHRu3W/c83tkdi22xdRYqejjLYmRv0tjBYg9VJQHRPaV/yCS01Y6t4J1SbQIJQag5vqj
 zhgjQOx+UPF/mKX4UsOtztlGOOFn1wtWq8qn1cSEikWMiSgshYE4HhbHJqqYCrgxuD6U
 KQh4E/LGGd20x/6dCIYiyZfQR/WbfevKYMIelPDi+6d2AmO9Nr2TgIWJvXZLTGlo8+6M
 wpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706688783; x=1707293583;
 h=subject:cc:from:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfvqDFWTPL3MkyynuCtvPHgsOFdtZK9xcaIxW9NzxDI=;
 b=CgLqXn2xZDtNmo9XS+sygoT33YWQhfj1rjUBf1Rlnp72v91JlhlZqvqeZhaZaycK9B
 0U7jKXo4GcUOZYxE0ikB9yDe0peKYOwy+ITE7f+E44i+jRjzJ37ZcQ96uNhtuDQCEuih
 95+pyTao8H8wnsjKj6pHdUbcL5qSlFm3JigizKxaqq3f8gacbwF9z4/B+ku6LdKLcWhD
 GswAg4XArbVnfbYaDDcp5x5cdG8FkT0J6Db7yjbk+rnICNevVp/03H8I5Io6DTrFpi8G
 TiNgJ1BTo/5Dr2Ir2fm4RDNkvN1QUAvcKnl+fMPiBq2f8YK1ff5CwrxhakLlScpvbJI+
 guLA==
X-Gm-Message-State: AOJu0Yw5cy8ZccmwX6M8R0oZttjMEMBp+SwOMmqQ43o1YjQm6St1hK7c
 LZ37+7eU4NdMOKrXsgnzCQrzvhfSbHlB2ItAjmBf8kv1kWOpuwBy2n2Jdqk+wnolTX2j
X-Google-Smtp-Source: AGHT+IHKdgtXPZ2QTTPE7+qcaKi6MzM8ziHmHq2sfeuDOHcvu02sdnMEbeNoguBkdY8GXPrQZPidMA==
X-Received: by 2002:ac8:5713:0:b0:42a:8dfd:a876 with SMTP id
 19-20020ac85713000000b0042a8dfda876mr940449qtw.58.1706688783092; 
 Wed, 31 Jan 2024 00:13:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUCP/AurAL99JuHzuSgcyXrMUrBr+UZDOTz8IhfKYvxF3bth7c8YJv8aQPo5OuwUDi9OROj6XJAvRK+2IKWTSc4OTHK74ZunY5G1xpaRRsHoYM5uuApRBBwtyWtCtnvvEHCmJaBWy+i2gH2eMrtHiss3xIJCPW33eAKM+u/zTMWLWsDzpKycvEUnpyj7OYClII/e9dsBXW2cXZZjBc=
Received: from [0.0.0.0] ([2001:19f0:0:457c:5400:4ff:fe9e:f10c])
 by smtp.gmail.com with ESMTPSA id
 i14-20020ac8488e000000b0042a9d50422esm3387403qtq.76.2024.01.31.00.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 00:13:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------l0Fkjm0703bosivtns0WF5Ob"
Message-ID: <94cf974b-05ec-41c2-8d0b-43ffbc8bdeac@gmail.com>
Date: Wed, 31 Jan 2024 16:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-trivial@nongnu.org
From: Zhang Wen <zhw2101024@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org
Subject: building qemu on a system with libxkbcommon installed but not
 xkeyboard-config produces an core dump
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=zhw2101024@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 Jan 2024 07:11:36 -0500
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
--------------l0Fkjm0703bosivtns0WF5Ob
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

With this patch, qemu requires keyboard-config when libxkbcommon is 
found on the system. So if the qemu is configured when libxkbcommon is 
installed but not keyboard-config, the configure stage will produce an 
error message, thus avoid coredump in the build stage.

--------------l0Fkjm0703bosivtns0WF5Ob
Content-Type: text/plain; charset=UTF-8;
 name="0001-requires-xkeyboard-config-when-libxkbcommon-is-avail.patch"
Content-Disposition: attachment;
 filename*0="0001-requires-xkeyboard-config-when-libxkbcommon-is-avail.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlMGIxZTQ3OWU4YTgyZjdhNzk0MGNhNzBiNTEzNmJmMTBlMzY3NTZiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZyBXZW4gPHpodzIxMDEwMjRAZ21haWwuY29t
PgpEYXRlOiBGcmksIDI2IEphbiAyMDI0IDE3OjA5OjEwICswODAwClN1YmplY3Q6IFtQQVRD
SF0gcmVxdWlyZXMgeGtleWJvYXJkLWNvbmZpZyB3aGVuIGxpYnhrYmNvbW1vbiBpcyBhdmFp
bGFibGUgdG8KIGF2b2lkIGJ1aWxkIGVycm9yCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZyBXZW4g
PHpodzIxMDEwMjRAZ21haWwuY29tPgotLS0KIG1lc29uLmJ1aWxkIHwgMyArKy0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IGQwMzI5OTY2ZjEuLjIzM2MwMDY3
NTQgMTAwNjQ0Ci0tLSBhL21lc29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC0xMDkz
LDYgKzEwOTMsNyBAQCBlbHNlCiAgIHhrYmNvbW1vbiA9IGRlcGVuZGVuY3koJ3hrYmNvbW1v
bicsIHJlcXVpcmVkOiBnZXRfb3B0aW9uKCd4a2Jjb21tb24nKSwKICAgICAgICAgICAgICAg
ICAgICAgICAgICBtZXRob2Q6ICdwa2ctY29uZmlnJykKIGVuZGlmCit4a2V5Ym9hcmRfY29u
ZmlnID0gZGVwZW5kZW5jeSgneGtleWJvYXJkLWNvbmZpZycpCiAKIHNsaXJwID0gbm90X2Zv
dW5kCiBpZiBub3QgZ2V0X29wdGlvbignc2xpcnAnKS5hdXRvKCkgb3IgaGF2ZV9zeXN0ZW0K
QEAgLTM5NzgsNyArMzk3OSw3IEBAIHN1YmRpcigncWdhJykKIGlmIHhrYmNvbW1vbi5mb3Vu
ZCgpCiAgICMgdXNlZCBmb3IgdGhlIHVwZGF0ZS1rZXltYXBzIHRhcmdldCwgc28gaW5jbHVk
ZSBydWxlcyBldmVuIGlmICFoYXZlX3Rvb2xzCiAgIHFlbXVfa2V5bWFwID0gZXhlY3V0YWJs
ZSgncWVtdS1rZXltYXAnLCBmaWxlcygncWVtdS1rZXltYXAuYycsICd1aS9pbnB1dC1rZXlt
YXAuYycpICsgZ2VuaCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlcGVuZGVuY2ll
czogW3FlbXV1dGlsLCB4a2Jjb21tb25dLCBpbnN0YWxsOiBoYXZlX3Rvb2xzKQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBbcWVtdXV0aWwsIHhrYmNvbW1v
biwgeGtleWJvYXJkX2NvbmZpZ10sIGluc3RhbGw6IGhhdmVfdG9vbHMpCiBlbmRpZgogCiBp
ZiBoYXZlX3Rvb2xzCi0tIAoyLjQzLjAKCg==

--------------l0Fkjm0703bosivtns0WF5Ob--

