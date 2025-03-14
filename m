Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF4C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt5vI-0007zH-Ax; Fri, 14 Mar 2025 10:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tt5vG-0007yp-J7
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tt5vC-0005Yp-3V
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741962114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R0knWMTTLYPsNZMI/vZDl8brH0nUI45YRKVIAGyjquM=;
 b=iRsyzeS8oePQDnfSLHUSEHY006fshGG74UhzEF1C4YwklQ0vL1DWhw+q1pKohjKbFiaobL
 PkvZzl4VY0m/bkr6hFrGISLIeP7qvgh3ozh2PmRTTQGRH02qASMJQ0+Fk150g+x8p6dd6A
 nE3fzRZLB8PcWoT4PghaoXxCoL/21EE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-QtNi_QXYNUylbYh5yccqxQ-1; Fri, 14 Mar 2025 10:21:52 -0400
X-MC-Unique: QtNi_QXYNUylbYh5yccqxQ-1
X-Mimecast-MFC-AGG-ID: QtNi_QXYNUylbYh5yccqxQ_1741962112
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e6a340f8c7so2029604a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 07:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741962111; x=1742566911;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0knWMTTLYPsNZMI/vZDl8brH0nUI45YRKVIAGyjquM=;
 b=ss08dHWqECU1CGWo9K7pzTSKrET2fooMkXjeWDVAqP/G0RAan7ktR9a5l27jQqeijq
 S56NUeVg0QkL03PfrAypHgbfXJ9UDM5nIqGD7ejH2uzXKPTt7tg2kZ9P60IJcK3Jta/l
 6V7fabWeVU6oNA5KedDKEmnf4xm9KNSBRUBh972vOea5BqFf+yT69XMdAx/ZRm7onZ2p
 mLzk16oOQhOzV8CPNi4s2Af8wxNuePO6zhIeQY3gxA8/ogJnBCJ+Qiatwl8ySYbrXauf
 SfOQYoQ5lnhX6xDyhvl2fg3vtTyV4YoCf9p36aHEWOVhDtxTgHEzgb/1dazF0ZYl13Rf
 Y2Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaB0KGglWyVnB/4abvyqQdCAHgjW8SVaKoSsSttTGpZmZaarCMHpRQEnzpzKB1xpDgUswn6n5KIC4B@nongnu.org
X-Gm-Message-State: AOJu0YzY+neJiwTp+aeuitrAIbrOTN98sc0A2FkJUSwUO5hPnQ4vtu/J
 Mxmz5Z29XXves1f0uBFDeGHGLDVHGd2UDK5zopf68x1KFQzZpaDAgzT7qLsAaakwjTCgRpaftrZ
 OSnUJCr+9gDtdNh8G1iT4QAPAEtWRdGDOMNevsy2Ebz9NOO2pfuLc
X-Gm-Gg: ASbGncusB1rPP91dfLXzyHveJpjzb/CgJLtfTrmDadA4PXL1cT8l/Q72mPx5wDm685z
 CXGqfSaNvq6Ls48iuEMgp2O9hjBbS1VFdQGcILon12QVga4v7zPPjE6CzESSHX6IjQdM0gMB9jX
 YpvHc2BHhnt9mRN3h7remb6H6mYD+1nKIQUw1k9gf+d9ePk3VNZExFU4OFBCWBj+jJD1rB48UEa
 itr78bw2PCvU9hGNzEWj6iZBD7ihIiOhX8vkJkG87rfWN/0OzkamuuJZpfcsuUb+a6ytNvnEtCa
 yMau6bESZYH3YC6tmkh9AQ==
X-Received: by 2002:a05:6402:5cd:b0:5e5:c76f:c019 with SMTP id
 4fb4d7f45d1cf-5e89fa3953dmr2904766a12.17.1741962111466; 
 Fri, 14 Mar 2025 07:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFanjH+UnTpqz8Qb748WLSkNV9BlnXl5Yy6KVzCKdXkxTgQwz7qlAVO2zGYKd+7E6X4Q5MdCw==
X-Received: by 2002:a05:6402:5cd:b0:5e5:c76f:c019 with SMTP id
 4fb4d7f45d1cf-5e89fa3953dmr2904742a12.17.1741962111077; 
 Fri, 14 Mar 2025 07:21:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5e81692e5cbsm1994870a12.6.2025.03.14.07.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 07:21:50 -0700 (PDT)
Message-ID: <ad3cacce-cfc2-4855-b7a4-a972745508b4@redhat.com>
Date: Fri, 14 Mar 2025 15:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cross-compilation artifact is broken
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yan Vugenfirer <yvugenfi@redhat.com>
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com> <Z9GY3l2pTkbpMV8L@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z9GY3l2pTkbpMV8L@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/12/25 15:23, Daniel P. Berrangé wrote:
>>> My question is, is this expected behavior or is this a bug?
>>
>> Your configure args don't include "--enable-debug", so I would
>> not have expected -gsplit-dwarf to have been enabled, so I'm
>> surprised that commit casued a problem.
> 
> Hmm it appears that the meson  "get_option('debug')" is entirely
> unconnected to QEMU's --enable-debug configure flag, which I did
> not realize.

Indeed get_option('debug') is connected to --enable-debug-info (which is
default-enabled).

> IOW, we've got -gsplit-dwarf enabled by default for everyone
> building QEMU, which feels dubious. IMHO only an explicit
> --enable-debug configure arg should have triggered it.

I didn't realize that you meant to attach it to --enable-debug.  The
reason why meson.build checks get_option('debug') is simply because
-gsplit-dwarf implies turning on debug info.

Maybe it could use something like

diff --git a/configure b/configure
index 5d19d0036a1..18fd82a187e 100755
--- a/configure
+++ b/configure
@@ -1873,6 +1873,10 @@ if test "$skip_meson" = no; then
        { test "$host_os" = linux || test "$host_os" = "windows"; }; then
        echo 'werror = true' >> $cross
    fi
+  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
+      echo 'split_debug = true' >> $cross
+  fi
+
    echo "[project options]" >> $cross
    if test "$SMBD" != ''; then
      echo "smbd = $(meson_quote "$SMBD")" >> $cross
diff --git a/meson_options.txt b/meson_options.txt
index 809d0b42ef7..751dc39d22f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -360,7 +360,7 @@ option('debug_mutex', type: 'boolean', value: false,
         description: 'mutex debugging support')
  option('debug_stack_usage', type: 'boolean', value: false,
         description: 'measure coroutine stack usage')
-option('split_debug', type: 'boolean', value: true,
+option('split_debug', type: 'boolean', value: false,
         description: 'split debug info from object files')
  option('qom_cast_debug', type: 'boolean', value: true,
         description: 'cast debugging support')

similar to --enable-werror... by the way I'm not sure if checking
for .git still works - I think recent RPM creates a fake git repo
to be able to run "git am", does it get rid of the .git directory
before starting the build?

> In addition since its breaking Windows builds, it appears we
> need to block its usage on Windows.

Yes, that's needed.

Paolo


