Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA935E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 15:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKfqY-0006YN-Le; Mon, 09 Dec 2024 10:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tKfqW-0006Y0-7i
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tKfqU-0006Kc-8p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733758727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sole7iq33jW8RO+lox2CKK50LK/GyU6RZHjCU+SDasI=;
 b=dM6PjoEcUnEtEbX6Kbdz4bzFkXU2bwG8w0ilMrXTgLtJ+KjSISWeyPbGhxPjptnUNcYGt0
 pd2ha8OMZq4xI1vYUeHN0IJPK3Q1YqFj+wEEGS8SdrB26eLPS6/V4eRhngPLzlzn0B/6Z8
 4FJ7cW1m94SC6RFU7MR6f/XuiLnbGZc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-yy6smd1YOsmewtXFVCM3ow-1; Mon, 09 Dec 2024 10:38:45 -0500
X-MC-Unique: yy6smd1YOsmewtXFVCM3ow-1
X-Mimecast-MFC-AGG-ID: yy6smd1YOsmewtXFVCM3ow
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef114d8346so4071744a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 07:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733758724; x=1734363524;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sole7iq33jW8RO+lox2CKK50LK/GyU6RZHjCU+SDasI=;
 b=JfSlLTum2hkSk4R3h6HEWXGlJS0tX8kv6TqploONxxJxY/KTz3TttgEfAkGeuaCspj
 W/XyFX2AC8cDU9PIcIIJHg+tQFuXVcVN+lnRghlAh+2IkaMxL97Mr3Q4ZJSCnH2gT0sT
 6QQfBQWjcvXEZFZ+bCiNMD9GofRlINhC5rjLbAQ4aTN6u6Zi6Mx4dpNbmOeENjuZLJRY
 waTuJuXCPGGDGDC2ggoNYaMPKPU9ubhbrlJh7/LNXavoyWdEaDjttC/RY8uexj13ctrc
 w/XTe8X0/Ic+xIS8/9grWLolRr6PqdVOSqsrRU/Es8hq9Bdmn7oA1geh5QGejLkjn89J
 bJlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWikdWgRlJ/BIRSxy3MbCP+eXaSTMSYwW7rzub8yMNMUQOyg8HA+QIjLBs0hrfVDGrx4uoWKtKVlUK@nongnu.org
X-Gm-Message-State: AOJu0YyVpXRma6EhGJgixvukTVz84njNW9XGJUoUApPXpNkix93kOq/o
 lyuGhuOCMJmk5HYn7cE0U2TGOFYwk+XG/vPZNbK5kJazYtfXS/is/UJ7eXE/zl7EOXOdBHHkQzt
 jN8GxeA5+uNEl7ajpiWZPKDQPwF2BHBguXGir2OX5cy84SIub91bV
X-Gm-Gg: ASbGncvwpvkdVRcKspD5bzUpVBkaQgvIW4jzq3TwQskQjj+1VFCOsXEMKGzplSwTILQ
 4fMLznU7buMcxhiIw+KudgmMJXN9g5UDTO3BKP3BDhRAbLP0m74EFdKa+cyCEeAjNjM08SF0kSN
 e9ltpStSlFjHWk4UkXEZM85/1MjDhFPoS1ucRD+7Ac4g9TFv19MLHZF4+3u0dvdaFYzg7LIPobC
 C2yfSGOJfcVfiizsEjdc7ZSzO1qQ3cd6cDd8ubzQxBAzQ0WH+BeoIRelGAO00V+3Mjm
X-Received: by 2002:a17:90b:1c07:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-2efcf148832mr1426706a91.14.1733758724407; 
 Mon, 09 Dec 2024 07:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0aRqI8wrpc1TjjsFzoSJ8ZgxxFe9EQjG30KXTgUUFlZjkVPpOLkxT2yJnlNHtyCsiFl96/g==
X-Received: by 2002:a17:90b:1c07:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-2efcf148832mr1426678a91.14.1733758724077; 
 Mon, 09 Dec 2024 07:38:44 -0800 (PST)
Received: from smtpclient.apple ([203.163.235.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef4600d2c4sm8889098a91.47.2024.12.09.07.38.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2024 07:38:43 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <Z1cIY357gcsE1IgJ@intel.com>
Date: Mon, 9 Dec 2024 21:08:26 +0530
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tsirkin <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FE9B724-4233-4D94-AC17-5D6B90F55D7C@redhat.com>
References: <20241208064810.893451-1-anisinha@redhat.com>
 <Z1cIY357gcsE1IgJ@intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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



> On 9 Dec 2024, at 8:40=E2=80=AFPM, Zhao Liu <zhao1.liu@intel.com> =
wrote:
>=20
> +Daniel,
>=20
> On Sun, Dec 08, 2024 at 12:18:10PM +0530, Ani Sinha wrote:
>> Date: Sun,  8 Dec 2024 12:18:10 +0530
>> From: Ani Sinha <anisinha@redhat.com>
>> Subject: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
>> X-Mailer: git-send-email 2.45.2
>>=20
>> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
>> introduced 'default_cpu_version' for PCMachineClass. This created =
three
>> categories of CPU models:
>> - Most unversioned CPU models would use version 1 by default.
>> - For machines 4.0.1 and older that do not support cpu model aliases, =
a
>>   special default_cpu_version value of CPU_VERSION_LEGACY is used.
>> - It was thought that future machines would use the latest value of =
cpu
>>   versions corresponding to default_cpu_version value of
>>   CPU_VERSION_LATEST [1].
>>=20
>> Unfortunately, all pc machines still use the default cpu version of 1 =
for
>> unversioned cpu models. Only microvms use CPU_VERSION_LATEST.
>=20
> Hi Ani,
>=20
> So could we use CPU_VERSION_LATEST for other machines now?
>=20
> Mapping unversioned cpu models to the latest version sounds like more
> user friendly.

Note that even though that was the intention when default_cpu_version =
was introduced, it was never done that way. We have been using cpu =
version 1 for a long time.

>=20
> Regards,
> Zhao
>=20
>> This change cleans up the complicated logic around =
default_cpu_version
>> including getting rid of default_cpu_version property itself. A =
couple of new
>> flags are introduced, one for the legacy model for machines 4.0.1 and =
older
>> and other for microvms. For older machines, a new pc machine property =
is
>> introduced that separates pc machine versions 4.0.1 and older from =
the newer
>> machines. 4.0.1 and older machines are scheduled to be deleted =
towards
>> end of 2025 since they would be 6 years old by then. At that time, we =
can
>> remove all logic around legacy cpus. Microvms are the only machines =
that
>> continue to use the latest cpu version. If this changes later, we can
>> remove all logic around x86_cpu_model_last_version(). Default cpu =
version
>> for unversioned cpu models is hardcoded to the value 1 and applies
>> unconditionally for all pc machine types of version 4.1 and above.
>>=20
>> This change also removes all complications around CPU_VERSION_AUTO
>> including removal of the value itself.
>>=20
>> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
>>=20
>> CC: imammedo@redhat.com
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>



