Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F6AC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgMb-00054m-4J; Thu, 13 Jun 2024 05:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHgMa-00053p-45
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:03:20 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHgMY-0001UJ-7v
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:03:19 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c525257feso1001011e87.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718269396; x=1718874196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GTAPDQeK2ZImkEJxib9lQbC2uJGHaVZxjtpPbnSaY98=;
 b=QlT/tLKO16Q2qtifnKAx/aZ0zONA8bOiUlNdtBlCq0glntBiHjkqpZqy3C3xv2tYer
 zzcOnV5VRkf2ypxPsog1SR88Y+F+ER2X6zk/QXpgGk2FwQzROB1NM3ksxW1xJLyrbLVJ
 REAP6mVR2T85wmpKTBmVy+/3BYQgOUcQKbwQoJcWp2aYkA0Wx/YOi3K9fIdIF2UM3vtf
 FCCosh0bfGdw1ncPO8PLLPlEWciMRuX8wtxDpkl/0RW6Js9EQEPmLzRj+Cyqr276Ji5v
 V1r/eVGci9pP57PA4B+imrI9ByE+2wZeutNZ01fzIERm0TLlvqoKBrZdtB3WAx4kY/i2
 TkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718269396; x=1718874196;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GTAPDQeK2ZImkEJxib9lQbC2uJGHaVZxjtpPbnSaY98=;
 b=xE5jLDZ55twCjxcBOT5knYRC9Hnoc/w3TJD3DfsgyB61vQjdrOWgF4RLvzXnL/XKWB
 TwOcc2umwfdwJ5hEUv1yPNo8RJmRbv8ucjwNLBtMB/9gpVvt6/JZY91jLPssV58UrRwi
 NgSc/MYskns3JLRtwW+utLKlypI6uYVl5cScAZi4o30C8U7/NnIPcUnLHZhkwXHF9nw5
 l07lY+LY1Ryu2vSgVP+wlQAYA5ZepprnvfJIxzkkC0K4ia5A+Eomix3ToT1UxUaQRmtD
 894dPBZVBojOR1y70WKMwAxG5YLozSupfHKV4uzhU3iZWVCKsWTNJ91shmz2k/1hELvR
 ukbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTDMG6j60eR5gPpPsGhzB3Pgr6XvxVzii+F1P1nGwifL3M/EFLsrpcWL2TNRVAs91SPDvagMVUnuakwVxe1/vBJK0OGTM=
X-Gm-Message-State: AOJu0Yy1arYj7uYEYqEDH5+WfwdDcjAwoPkc0re5ds0RQbh2C0QY/JMQ
 s92YA2P9z5yK5gXw9IDawJaCMnVEpar5MfUjIkpbwfPDWpi9NAFC4kLq0Vir4lo=
X-Google-Smtp-Source: AGHT+IG7X7YYLBKJkmgjedIF9gnzp3DU0GppNNd5qp3JF8IuuqwJn5ZXsZzYMrP1SGqg53OomLnQwA==
X-Received: by 2002:a05:6512:2098:b0:52c:8051:5799 with SMTP id
 2adb3069b0e04-52c9a3b7a0fmr2121133e87.11.1718269396352; 
 Thu, 13 Jun 2024 02:03:16 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe9230sm53155675e9.17.2024.06.13.02.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 02:03:16 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:59:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <ZmquNSnnVSdOe0Z3@intel.com> <f0gdl.ugeo9rfbpd5e@linaro.org>
 <Zmqzf6C9QyacG0Fn@redhat.com>
In-Reply-To: <Zmqzf6C9QyacG0Fn@redhat.com>
Message-ID: <f0h5e.89ncc7cio1kx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 13 Jun 2024 11:53, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Thu, Jun 13, 2024 at 11:41:38AM +0300, Manos Pitsidianakis wrote:
>> > > diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
>> > > new file mode 100644
>> > > index 0000000000..ebecb99fe0
>> > > --- /dev/null
>> > > +++ b/rust/rustfmt.toml
>> > > @@ -0,0 +1,7 @@
>> > > +edition = "2021"
>> > > +format_generated_files = false
>> > > +format_code_in_doc_comments = true
>> > > +format_strings = true
>> > > +imports_granularity = "Crate"
>> > > +group_imports = "StdExternalCrate"
>> > > +wrap_comments = true
>> > > 
>> > 
>> > About the Rust style, inspired from the discussion on my previous
>> > simpletrace-rust [1], it looks like people prefer the default rust style
>> > and use the default check without custom configurations.
>> > 
>> > More style requirements are also an open, especially for unstable ones,
>> > and it would be better to split this part into a separate patch, so that
>> > the discussion about style doesn't overshadow the focus on your example.
>> > 
>> > [1]: https://lore.kernel.org/qemu-devel/ZlnBGwk29Ds9FjUA@redhat.com/
>> > 
>> 
>> I had read that discussion and had that in mind. There's no need to worry
>> about format inconsistencies; these options are unstable  -nightly only-
>> format options and they don't affect the default rust style (they actually
>> follow it). If you run a stable cargo fmt you will see the code won't change
>> (but might complain that these settings are nightly only).
>> 
>> What they do is extra work on top of the default style. If anything ends up
>> incompatible with stable I agree it must be removed, there's no sense in
>> having a custom Rust style when the defaults are so reasonable.
>
>This doesn't make sense. One the one hand you're saying the rules don't
>have any effect on the code style vs the default, but on the otherhand
>saying they do "extra work" on top of the default style. Those can't
>both be true.

No, I fear there's a confusion here. It means that if you run the stable 
rustfmt with the default options the code doesn't change. I.e. it does 
not conflict with the default style.

What it does is group imports, format text in doc comments (which stable 
rustfmt doesn't touch at all) and also splits long strings into several 
lines, which are all helpful for e-mail patch reviews.

Thanks,
Manos

