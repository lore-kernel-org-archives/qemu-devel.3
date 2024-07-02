Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D4AC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOekR-0008IV-5W; Tue, 02 Jul 2024 10:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOekP-0008Hm-M7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:44:45 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOekM-00072k-Hh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:44:45 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cecba8d11so5202813e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719931478; x=1720536278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EuHGikV1Xu3ZOawZ3lxMeDpvvmh+YBc4mVHIE954ujA=;
 b=LWGF4n5OGQHuLFmo0GIiK/psxNi/Vlu7gIRc0pCmf4xXuNfFfGnNys3S1HGACQ9NTZ
 LlNI8fz6Bbg/pYz1L3VbrILXUy1ou86RqW9juXi03+H4dLP54SkjcG0MswEO6qnzj6aH
 QnuG1D4mYfQSkDOUq731xpPrpgtO5ALTa/q7UnJnHmax/GCF6cofWWi4DH909wAhoZUo
 Rkx+AexE7k7B7rNIW0NVKxw3VAiQlRytiVFKakjvNADHsuAtrP3ZZubEootpv59mKm/i
 5Eqa/2/lUJoTQHOQh4Fw8F5heFF7mFqf+hNjdUIBif44HrEr55WJ2x6GsTdoxVy4B/xq
 +McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719931478; x=1720536278;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EuHGikV1Xu3ZOawZ3lxMeDpvvmh+YBc4mVHIE954ujA=;
 b=qItRgcnN1zo4ueAqeC52LxnqsB/PW+v3lwFSdr71hcwtG8rVYB4vN/GkI2+EwN8RdI
 8DKn0nsGMH+E8g8S1qLchqStTaz8D8Tj1FEo0QZk4hL0+yaAG+JoqvtN4HqkN0drA8Lh
 ctmJADfb2gvYB4Zji8UWPROFrQf/HlbuUIoMV5tfDoR/nH8U2RXev/E90GGgR3BZ6i8t
 UuKYt+ckCBJY7J7DGBQKvL7jwcJIN8Q2tJtlbAirAnhvvlFGYQdp3iDTdFNqCln1Y2HU
 +dInr/NvTuxxRN7hiLVyFvsyiywVFOyiWddZaZeaq2xYBoeOq8UJKV5uZXk20OzyKExK
 JfOg==
X-Gm-Message-State: AOJu0Yz/3ZK9DAh1Zc0PnqdB5ho5F2kUgfuT5zrf2H+x4AK9r/feEq1Q
 OQoacNXF72tNpG+ewANKbGxoVMWMSewFa5lxTgbtgx3DgpVk3XtO9TWs58meNhGfTs/VdUfgZL0
 pJMM=
X-Google-Smtp-Source: AGHT+IGDVnof08/MHmBWTZvbKV0AL+1D9cfUqg2WT7NDU1C6pEjvMamPFWmipuLGecp5IqtyCt3szA==
X-Received: by 2002:a05:6512:1246:b0:52c:850b:cfc6 with SMTP id
 2adb3069b0e04-52e82688110mr6357681e87.38.1719931477729; 
 Tue, 02 Jul 2024 07:44:37 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678fe13ef4sm193274f8f.117.2024.07.02.07.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:44:37 -0700 (PDT)
Date: Tue, 02 Jul 2024 17:38:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnmkN2PL3r-2sxqe@redhat.com>
In-Reply-To: <ZnmkN2PL3r-2sxqe@redhat.com>
Message-ID: <g03mb.04m2bqm0mj1q@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
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

Hi Daniel, I missed one of your questions and I just re-read the thread 
today,

On Mon, 24 Jun 2024 19:52, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Wed, Jun 19, 2024 at 11:13:58PM +0300, Manos Pitsidianakis wrote:
>> Add options for Rust in meson_options.txt, meson.build, configure to
>> prepare for adding Rust code in the followup commits.
>> 
>> `rust` is a reserved meson name, so we have to use an alternative.
>> `with_rust` was chosen.
>> 
>> A cargo_wrapper.py script is added that is heavily based on the work of
>> Marc-André Lureau from 2021.
>> 
>> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/
>> 
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  MAINTAINERS                   |   5 +
>>  configure                     |  11 ++
>>  meson.build                   |  11 ++
>>  meson_options.txt             |   4 +
>>  scripts/cargo_wrapper.py      | 279 ++++++++++++++++++++++++++++++++++
>>  scripts/meson-buildoptions.sh |   6 +
>>  6 files changed, 316 insertions(+)
>>  create mode 100644 scripts/cargo_wrapper.py
>
>> diff --git a/configure b/configure
>> index 38ee257701..6894d7c2d1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -302,6 +302,9 @@ else
>>    objcc="${objcc-${cross_prefix}clang}"
>>  fi
>>
>>[..snip..]
>> +with_rust_target_triple=""
>> +
>>  ar="${AR-${cross_prefix}ar}"
>>  as="${AS-${cross_prefix}as}"
>>  ccas="${CCAS-$cc}"
>> @@ -760,6 +763,12 @@ for opt do
>>    ;;
>>    --gdb=*) gdb_bin="$optarg"
>>    ;;
>> +  --enable-with-rust) with_rust=enabled
>> +  ;;
>> +  --disable-with-rust) with_rust=disabled
>> +  ;;
>
>--enable-with-XXX / --disable-with-XXX is pretty unsual naming.
>
>Normally you'd see either --enable-XXX or --with-XXX and their
>corresponding --disable-XXX or --without-XXX.

True. As the commit message says, `rust` is a reserved meson feature 
name, so the auto-generated scripts/meson-buildoptions.sh
has the following args:

  --enable-with-rust
  --disable-with-rust

I used the same in `configure` even though it's not autogenerated in 
order to keep the two synced. If there's a way to get around this I'd 
prefer it.


