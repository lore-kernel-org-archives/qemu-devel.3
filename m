Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAEFC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNcL-0007kV-6H; Tue, 20 Feb 2024 05:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNcJ-0007k8-ST
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:44:51 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcNcH-0002fW-VC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:44:51 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-511976c126dso6437178e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708425888; x=1709030688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NDP3py1mD74J9J6jtctk4StkvJa47UeYUeejEIihAyw=;
 b=yPxp7/DPTouy6Bnuds6vWkZqztpaVaI1CT8pTeKjjOBah1UtIcIj7iNUMIzB2y+YsH
 3WSRwiZjCOEVe+KuQB19JrcGMP/EIkAAinjrvtdBkH4j/7vJpksnGtxrlYfGyZHeDk/X
 avtIM5Wh97gyQUCG5FcR5loURDbGYP/yKpIgxZbb+mv7kcBCyZWTRYvXXGtk1NrWIKk0
 S64+p2O9MyUaKyL3QbDLWtCZEvXV6qUr39xaU3mFHzD24kX+oKKX0TStORWPwU6wSB7v
 wcEkclgF/VzqIothIO9tKmKMHtwJmfBcskga892AnRPesbBA2YcnNQigg2UuQqZjmNPI
 TafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425888; x=1709030688;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NDP3py1mD74J9J6jtctk4StkvJa47UeYUeejEIihAyw=;
 b=U6/iQlh67vvzuOX2uH7Crgr8IxxeMyV/b2QPCkeTBLPai0EIvsAgSNjAQDbCqhefck
 O7Aqpa9yiknNJNB11TdR77PeuTKXaPU3o13mffJ8Y4KpffzHLRSkQ8CrBd7sqgp87Df+
 mfB2qRBtVWIzQBz8OfWqYT4gIySe6f1D0MfMbVj56gdtqFHaghe8PIhlf0mqf8RAYZJt
 xqOZp8E/7vYQ7QtvfvuisDhGvTE8t3gyD4/ER1dYyz4l8HHWJKdSohapYNQ6SlYp17Bm
 hqphr5BiDWz++/hjINbGPYVVe5xI+i6NMZGGq20rM+vonsET6eyLtvYHpHxpF9jdyB6W
 m7/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/nuQT0btDCndT0AZ/zaLQHLbLCbyqzI59IfwXvYXOoTSNz4TX8GjxZaxK8+ILMyB4I8DIShfkKyTfBRVsjYCKNyXd3rU=
X-Gm-Message-State: AOJu0YzSgMmZk3Vid0C1rEk2vqmSgrOnxz/KhvlZF95nAGVT8sfuuIGu
 1YdywmDAe4X/MBoaiyutPKilqGoeM8LdoNoNfGPmNOSs8K1L5WgrCZbwiYzYUq4=
X-Google-Smtp-Source: AGHT+IGFxHUobSnV4ACIV1E8ZYrDaY7p/x8eOwJQUkRYVpK5sX3uXjrW8KXH+7XYQUteaarbsfKJ4A==
X-Received: by 2002:a05:6512:3d8d:b0:512:be44:6570 with SMTP id
 k13-20020a0565123d8d00b00512be446570mr2613745lfv.36.1708425887986; 
 Tue, 20 Feb 2024 02:44:47 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 ew14-20020a056402538e00b005602346c3f5sm3537905edb.79.2024.02.20.02.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:44:47 -0800 (PST)
Date: Tue, 20 Feb 2024 12:42:28 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Hongren (Zenithal) Zheng <i@zenithal.me>,
 "Canokeys.org" <contact@canokeys.org>
Subject: Re: [PATCH v1 01/21] docs: correct typos
User-Agent: meli 0.8.5-rc.3
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
 <20240220053538-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240220053538-mutt-send-email-mst@kernel.org>
Message-ID: <95hul.sppswhjb0hah@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12b.google.com
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

On Tue, 20 Feb 2024 12:36, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Tue, Feb 20, 2024 at 10:52:08AM +0200, Manos Pitsidianakis wrote:
>> Correct typos automatically found with the `typos` tool
>> <https://crates.io/crates/typos>
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>> ---
>>  docs/devel/ci-jobs.rst.inc      | 2 +-
>>  docs/devel/docs.rst             | 2 +-
>>  docs/devel/testing.rst          | 2 +-
>>  docs/interop/prl-xml.txt        | 2 +-
>>  docs/interop/vhost-user.rst     | 2 +-
>>  docs/system/devices/canokey.rst | 2 +-
>>  6 files changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
>> index 4c39cdb2d9..6678b4f4ef 100644
>> --- a/docs/devel/ci-jobs.rst.inc
>> +++ b/docs/devel/ci-jobs.rst.inc
>> @@ -147,7 +147,7 @@ Set this variable to 1 to create the pipelines, but leave all
>>  the jobs to be manually started from the UI
>>  
>>  Set this variable to 2 to create the pipelines and run all
>> -the jobs immediately, as was historicaly behaviour
>> +the jobs immediately, as was historically behaviour
>
>as long as we do this let's fix grammar too?
>
>as was historically the behaviour

After the fact, I think it should be "as was historical behaviour".

I will re-spin with only this change, and keep the Acks/RoBs if that is 
okay with everyone.

Thanks,

>
>>  QEMU_CI_AVOCADO_TESTING
>>  ~~~~~~~~~~~~~~~~~~~~~~~
>> diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
>> index 50ff0d67f8..a7768b5311 100644
>> --- a/docs/devel/docs.rst
>> +++ b/docs/devel/docs.rst
>> @@ -21,7 +21,7 @@ are processed in two ways:
>>  
>>  The syntax of these ``.hx`` files is simple. It is broadly an
>>  alternation of C code put into the C output and rST format text
>> -put into the documention. A few special directives are recognised;
>> +put into the documentation. A few special directives are recognised;
>>  these are all-caps and must be at the beginning of the line.
>>  
>>  ``HXCOMM`` is the comment marker. The line, including any arbitrary
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index bd132306c1..aa96eacec5 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -728,7 +728,7 @@ For example to setup the HPPA ports builds of Debian::
>>      EXECUTABLE=(pwd)/qemu-hppa V=1
>>  
>>  The ``DEB_`` variables are substitutions used by
>> -``debian-boostrap.pre`` which is called to do the initial debootstrap
>> +``debian-bootstrap.pre`` which is called to do the initial debootstrap
>>  of the rootfs before it is copied into the container. The second stage
>>  is run as part of the build. The final image will be tagged as
>>  ``qemu/debian-sid-hppa``.
>> diff --git a/docs/interop/prl-xml.txt b/docs/interop/prl-xml.txt
>> index 7031f8752c..cf9b3fba26 100644
>> --- a/docs/interop/prl-xml.txt
>> +++ b/docs/interop/prl-xml.txt
>> @@ -122,7 +122,7 @@ Each Image element has following child elements:
>>      * Type - image type of the element. It can be:
>>               "Plain" for raw files.
>>               "Compressed" for expanding disks.
>> -    * File - path to image file. Path can be relative to DiskDecriptor.xml or
>> +    * File - path to image file. Path can be relative to DiskDescriptor.xml or
>>               absolute.
>>  
>>  == Snapshots element ==
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index ad6e142f23..d1ed39dfa0 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -989,7 +989,7 @@ When reconnecting:
>>  
>>     #. If ``d.flags`` is not equal to the calculated flags value (means
>>        back-end has submitted the buffer to guest driver before crash, so
>> -      it has to commit the in-progres update), set ``old_free_head``,
>> +      it has to commit the in-progress update), set ``old_free_head``,
>>        ``old_used_idx``, ``old_used_wrap_counter`` to ``free_head``,
>>        ``used_idx``, ``used_wrap_counter``
>>  
>> diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
>> index cfa6186e48..7f3664963f 100644
>> --- a/docs/system/devices/canokey.rst
>> +++ b/docs/system/devices/canokey.rst
>> @@ -14,7 +14,7 @@ CanoKey [1]_ is an open-source secure key with supports of
>>  All these platform-independent features are in canokey-core [3]_.
>>  
>>  For different platforms, CanoKey has different implementations,
>> -including both hardware implementions and virtual cards:
>> +including both hardware implementations and virtual cards:
>>  
>>  * CanoKey STM32 [4]_
>>  * CanoKey Pigeon [5]_
>> -- 
>> γαῖα πυρί μιχθήτω
>

