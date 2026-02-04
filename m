Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAC9E8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnRpH-0000yL-VR; Tue, 03 Feb 2026 20:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRpF-0000xy-QZ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:37:01 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRpE-0000ON-1r
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:37:01 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c62239decbeso2454786a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169018; x=1770773818; darn=nongnu.org;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3Rh6bvtADQt5Pf3JpTCI766uFGT8qIobiba6T/8t4M=;
 b=RfJksIeFv23SXorv3bawouIbbhAGDnF/yn29g8ZSpx9fqz34X8LxWD3EgRr4gikU8y
 0APs40AfV6TnDLCYGcPn+VTFOlsPOAP7qNNDY51L8ses+8HyrREuCoNvUBpoRFHdj9aC
 MkVogmrfhetoibj12Qn9L7C1+0A9ee0FHEdel3wvH9BnGgrH+YNXr2jj2E91RFP9FbLk
 pwscco8rLnLmBsgajS+pQTjP8pn/xiMufrIOPpQfDoQjJjEgCSOAY3mk2sxEk8bki3M5
 aj2xMrG0wM7vIQF6IlY9hofCJfm/1rMtqsSpTwi+3KS1xIvFjifPPxYGxDJgyWMWg7mw
 zJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169018; x=1770773818;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3Rh6bvtADQt5Pf3JpTCI766uFGT8qIobiba6T/8t4M=;
 b=oTTczMfQb5Md9CkIz8rwgyQsqr1Ozn2hWo5Ccjum7REZov+BgIeerNgvmc9kZtziH5
 OsSUR58mxqqG6U83whVr94V3YlwRXD6N4MHC0hUIXyzy76D4YGih8QLxLyw+QSbQ7xJa
 39ZhJP0gQ8lppFp/Lup5H274f8tfGUAPLzK3KrQSJaEVqyXmW7uAtXoaAS2QQ4qM4AYM
 vyHmNxgemCZ0Ch5ev+89Qb3ImG6/FMeBJYxnYlIiU3IVFatwLDO+4HSLkvOarSEKGfNL
 NzlckXfMOrUjw6k0JJbBDB385l8iHJf06oKKy9RvsEryAm8zQTljvPU4kNIglUcjzBE3
 3vvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI8juzwe8IPPpQj/1v9VFUN5X+cTH79qHjN7Cy9HIk64tLqmaDgqMRu3BbjMInoBS7r0jaKjUf2Kes@nongnu.org
X-Gm-Message-State: AOJu0YymszwCeOkaidxTE1CK2pnNsCgorDJhsb2tO3UhbJ/h3kPFR9Kq
 KABQM5RaCEOHedZfrIQIAwYgdUK7Htvnv5ZlfUf4FcMU+Il/Tm9PUd812digV62DkZI=
X-Gm-Gg: AZuq6aLeLz1eWNMVv75H6yJXTR18CxZalSA1w04Irx4qD4Ucbiaz+DgyW0y27CMXIfr
 /7A0Y5c4ZGqT3Z0MU0E/2+h7ZHWdHgw+hHb+ggRze4w6eCNpR0/QlgTtzbQMQO6V+dQ2PdiQWXM
 xYwP6FebWnBlyxWFG4vKRnn2V9hiDQHFzmfKBwzfE8RFjJ3woewdaefmCCQaqIccjxhprs8Slv/
 QhTJ3T7bwBslKR2nCLfOI3S1Cnj4xUS+EykQhHtHESQNzk9Ii2Oxbp1vjjmLya4/w2KOwkUc76+
 12Wzx+USX6rB8al22JG8g7N9JdOH1TKI7jeEeZGYWxIMzKv3EDLiPtS1oHM8vH3PsUKfSiiCp6/
 hgfkNSM48pryIDP2GoHrJmicgCE8wkZp6bDV/4avD0mKqN14kQgiibkG1X7ITttZiCKjl8jkkEa
 IgW6rzAOvzQUCkucR6UZrnNfRL4hUafa9Mx2fhL6fYLxj61054/ck64gmDkyXs8XqKW/A=
X-Received: by 2002:a17:903:2449:b0:2a9:322e:2473 with SMTP id
 d9443c01a7336-2a93400297fmr12107835ad.48.1770169018120; 
 Tue, 03 Feb 2026 17:36:58 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 ([2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93397c2fdsm6159655ad.87.2026.02.03.17.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:36:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------3AbknLye5FvJClELFIvVcM00"
Message-ID: <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
Date: Wed, 4 Feb 2026 11:36:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-info: set target_arch statically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------3AbknLye5FvJClELFIvVcM00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/26 05:41, Pierrick Bouvier wrote:
> target_arch() function will reparse target_name() every time if it was
> not set to a proper SYS_EMU_TARGET_* value (when using
> target-info-stub.c), which is not efficient.
> 
> Since we want to preserve the constness of TargetInfo but C doesn't give
> us flexible compile time expressions, we simply set target_arch using a
> static constructor once instead.

A static constructor isn't static initialization.
That said, we can do better with some extra help from meson; see attached.

I'm mildly annoyed with openrisc vs or1k.  We really ought to fix that, but I haven't 
looked into what API breakage we get from selecting one or the other.


r~
--------------3AbknLye5FvJClELFIvVcM00
Content-Type: text/x-patch; charset=UTF-8; name="target-arch.patch"
Content-Disposition: attachment; filename="target-arch.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3RhcmdldC1pbmZvLXN0dWIuYyBiL3RhcmdldC1pbmZvLXN0dWIuYwpp
bmRleCA4MzkyZDgxZThmLi42NTIyMGNjNzgyIDEwMDY0NAotLS0gYS90YXJnZXQtaW5mby1z
dHViLmMKKysrIGIvdGFyZ2V0LWluZm8tc3R1Yi5jCkBAIC0xOCw3ICsxOCw3IEBAIFFFTVVf
QlVJTERfQlVHX09OKG9mZnNldG9mKEFyY2hDUFUsIGVudikgIT0gc2l6ZW9mKENQVVN0YXRl
KSk7CiAKIHN0YXRpYyBjb25zdCBUYXJnZXRJbmZvIHRhcmdldF9pbmZvX3N0dWIgPSB7CiAg
ICAgLnRhcmdldF9uYW1lID0gVEFSR0VUX05BTUUsCi0gICAgLnRhcmdldF9hcmNoID0gU1lT
X0VNVV9UQVJHRVRfX01BWCwKKyAgICAudGFyZ2V0X2FyY2ggPSBnbHVlKFNZU19FTVVfVEFS
R0VUXywgVEFSR0VUX0FSQ0gpLAogICAgIC5sb25nX2JpdHMgPSBUQVJHRVRfTE9OR19CSVRT
LAogICAgIC5jcHVfdHlwZSA9IENQVV9SRVNPTFZJTkdfVFlQRSwKICAgICAubWFjaGluZV90
eXBlbmFtZSA9IFRZUEVfTUFDSElORSwKZGlmZiAtLWdpdCBhL3RhcmdldC1pbmZvLmMgYi90
YXJnZXQtaW5mby5jCmluZGV4IDVhNmQ3MjgyNTIuLmEyNjUzMmY2NjAgMTAwNjQ0Ci0tLSBh
L3RhcmdldC1pbmZvLmMKKysrIGIvdGFyZ2V0LWluZm8uYwpAQCAtMjQsMTMgKzI0LDcgQEAg
dW5zaWduZWQgdGFyZ2V0X2xvbmdfYml0cyh2b2lkKQogCiBTeXNFbXVUYXJnZXQgdGFyZ2V0
X2FyY2godm9pZCkKIHsKLSAgICBTeXNFbXVUYXJnZXQgYXJjaCA9IHRhcmdldF9pbmZvKCkt
PnRhcmdldF9hcmNoOwotCi0gICAgaWYgKGFyY2ggPT0gU1lTX0VNVV9UQVJHRVRfX01BWCkg
ewotICAgICAgICBhcmNoID0gcWFwaV9lbnVtX3BhcnNlKCZTeXNFbXVUYXJnZXRfbG9va3Vw
LCB0YXJnZXRfbmFtZSgpLCAtMSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
ZXJyb3JfYWJvcnQpOwotICAgIH0KLSAgICByZXR1cm4gYXJjaDsKKyAgICByZXR1cm4gdGFy
Z2V0X2luZm8oKS0+dGFyZ2V0X2FyY2g7CiB9CiAKIGNvbnN0IGNoYXIgKnRhcmdldF9jcHVf
dHlwZSh2b2lkKQpkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRl
eCA4YzZjMGE5YTMyLi4zNTc3MmUxNTc4IDEwMDY0NAotLS0gYS9tZXNvbi5idWlsZAorKysg
Yi9tZXNvbi5idWlsZApAQCAtMzI2Myw3ICszMjYzLDcgQEAgaG9zdF9rY29uZmlnID0gXAog
ICAoaHZfYmFsbG9vbiA/IFsnQ09ORklHX0hWX0JBTExPT05fUE9TU0lCTEU9eSddIDogW10p
ICsgXAogICAoaGF2ZV9ydXN0ID8gWydDT05GSUdfSEFWRV9SVVNUPXknXSA6IFtdKQogCi1p
Z25vcmVkID0gWyAnVEFSR0VUX1hNTF9GSUxFUycsICdUQVJHRVRfQUJJX0RJUicsICdUQVJH
RVRfQVJDSCcgXQoraWdub3JlZCA9IFsgJ1RBUkdFVF9YTUxfRklMRVMnLCAnVEFSR0VUX0FC
SV9ESVInIF0KIAogZGVmYXVsdF90YXJnZXRzID0gJ0NPTkZJR19ERUZBVUxUX1RBUkdFVFMn
IGluIGNvbmZpZ19ob3N0CiBhY3R1YWxfdGFyZ2V0X2RpcnMgPSBbXQpAQCAtMzM1Myw2ICsz
MzUzLDEzIEBAIGZvcmVhY2ggdGFyZ2V0IDogdGFyZ2V0X2RpcnMKICAgICAgICMgZG8gbm90
aGluZwogICAgIGVsaWYgaWdub3JlZC5jb250YWlucyhrKQogICAgICAgIyBkbyBub3RoaW5n
CisgICAgZWxpZiBrID09ICdUQVJHRVRfQVJDSCcKKyAgICAgICMgRklYTUU6IHN0YW5kYXJk
aXplIG9uIGVpdGhlciBvcjFrIG9yIG9wZW5yaXNjIGV2ZXJ5d2hlcmUKKyAgICAgICMgVGhp
cyB1c2FnZSBpcyBjb25jZXJuZWQgd2l0aCBwYXN0aW5nIGludG8gU1lTX0VNVV9UQVJHRVRf
Ki4KKyAgICAgIGlmIHYgPT0gJ29wZW5yaXNjJworICAgICAgICB2ID0gJ29yMWsnCisgICAg
ICBlbmRpZgorICAgICAgY29uZmlnX3RhcmdldF9kYXRhLnNldChrLCB2LnRvX3VwcGVyKCkp
CiAgICAgZWxpZiBrID09ICdUQVJHRVRfQkFTRV9BUkNIJwogICAgICAgIyBOb3RlIHRoYXQg
VEFSR0VUX0JBU0VfQVJDSCBlbmRzIHVwIGluIGNvbmZpZy10YXJnZXQuaCBidXQgaXQgaXMK
ICAgICAgICMgbm90IHVzZWQgdG8gc2VsZWN0IGZpbGVzIGZyb20gc291cmNlc2V0cy4KZGlm
ZiAtLWdpdCBhL3FhcGkvbWFjaGluZS5qc29uIGIvcWFwaS9tYWNoaW5lLmpzb24KaW5kZXgg
OTA3Y2IyNWY3NS4uZWY4NTc1YjZlYiAxMDA2NDQKLS0tIGEvcWFwaS9tYWNoaW5lLmpzb24K
KysrIGIvcWFwaS9tYWNoaW5lLmpzb24KQEAgLTI4LDYgKzI4LDggQEAKICMKICMgQGxvb25n
YXJjaDY0OiBzaW5jZSA3LjEKICMKKyMgQGhleGFnb246IHNpbmNlIDExLjAKKyMKICMgLi4g
bm90ZTo6IFRoZSByZXN1bHRpbmcgUU1QIHN0cmluZ3MgY2FuIGJlIGFwcGVuZGVkIHRvIHRo
ZQogIyAgICAicWVtdS1zeXN0ZW0tIiBwcmVmaXggdG8gcHJvZHVjZSB0aGUgY29ycmVzcG9u
ZGluZyBRRU1VCiAjICAgIGV4ZWN1dGFibGUgbmFtZS4gIFRoaXMgaXMgdHJ1ZSBldmVuIGZv
ciAicWVtdS1zeXN0ZW0teDg2XzY0Ii4KQEAgLTM1LDcgKzM3LDcgQEAKICMgU2luY2U6IDMu
MAogIyMKIHsgJ2VudW0nIDogJ1N5c0VtdVRhcmdldCcsCi0gICdkYXRhJyA6IFsgJ2FhcmNo
NjQnLCAnYWxwaGEnLCAnYXJtJywgJ2F2cicsICdocHBhJywgJ2kzODYnLAorICAnZGF0YScg
OiBbICdhYXJjaDY0JywgJ2FscGhhJywgJ2FybScsICdhdnInLCAnaGV4YWdvbicsICdocHBh
JywgJ2kzODYnLAogICAgICAgICAgICAgICdsb29uZ2FyY2g2NCcsICdtNjhrJywgJ21pY3Jv
YmxhemUnLCAnbWljcm9ibGF6ZWVsJywgJ21pcHMnLCAnbWlwczY0JywKICAgICAgICAgICAg
ICAnbWlwczY0ZWwnLCAnbWlwc2VsJywgJ29yMWsnLCAncHBjJywKICAgICAgICAgICAgICAn
cHBjNjQnLCAncmlzY3YzMicsICdyaXNjdjY0JywgJ3J4JywgJ3MzOTB4JywgJ3NoNCcsCg==


--------------3AbknLye5FvJClELFIvVcM00--

