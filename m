Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567CC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDtg-0003Pt-If; Tue, 06 May 2025 04:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCDte-0003Ke-Ei
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCDtc-0006FH-Mn
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746521003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekfWPmlcRu20I0INlQzkZcjFSIniyMODgHXybySRZ6w=;
 b=NBSJLpSd5OFABvznKx/efTq6iR84klBifdLErYzUp/w89PNBaUtGRRDt4Js7WYkJFJng+4
 Su25GcMGA9Gu80SE2djaJH/UlMcWurJZLvL3KrVOmRijR19pB+mtPZ4biWk/V6S7ucMIq+
 ZUW4btu9+1OB8Qpr/lVpYNNmvLN4CEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-cL1F8xkyPvOwfIF5bItJxQ-1; Tue, 06 May 2025 04:43:22 -0400
X-MC-Unique: cL1F8xkyPvOwfIF5bItJxQ-1
X-Mimecast-MFC-AGG-ID: cL1F8xkyPvOwfIF5bItJxQ_1746521001
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39d917b1455so1450350f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746521001; x=1747125801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekfWPmlcRu20I0INlQzkZcjFSIniyMODgHXybySRZ6w=;
 b=b0LWo0gWFDUORSbYHJC+WhTR9rqhVE29OnRLZgZrTXiCUVvH3FzZVjMyZ0Kb6f+8GI
 Krqq6pJc4hnA3Dyfd6eSRdaJWZEf9Bt8caQME1i28IlSiDjia5F/YeDfga7BbAc1i42t
 kSziXSrjtyIlqH1SQDoCmudgbxHhm24WvKu/1KeMu0rXQXltlhrlgAGxvwQpSn9jTqTx
 xLZFd2AMcF9f4Jp9THyNg5DH+bs3BA2yDNIGA6NpUbyF0YOhj6iEmcg11Viz1IaGIIud
 El5TD3+oSAL1flAYryx+OJcTkhqPnLXEyDlJc+a2wF3qJVgqq5MTgRRa/fvchLEdcIjE
 LAYQ==
X-Gm-Message-State: AOJu0YwQ2uIVjd3Dq+MESMVOSzCND76nNkmqgC+x3D3Bh3YWGFTyEm7J
 vpq5AwxWKVaiC51d5O1prLRJfQ9WjAvi9UnaiXpogxV4OOx6KkzjICxz0DX8kOo+g/cBnVsQkvw
 pF3v9AjCtLMfp9u5q0HeGrVCGon6is/WU3Ryf035ZhSJNFoFlzkMm6D5TXQ/5IBk6GmcoANY+sf
 /bv6uBOx/sS9t9yMOeWMTao/bLGBg=
X-Gm-Gg: ASbGncs8EasX1DpYRCV3sJrTKdldBNf5Bu8ah8TCW8V1dJrflPhj/TL7VGc/zi8d/4a
 gXqPQW+tncTkHudMS8rmTd992RxMqq01z/x/Yy/FrVPIKuyB3y09Bkr91Pi1urnnCKnzw
X-Received: by 2002:a05:6000:40e1:b0:3a0:8330:3377 with SMTP id
 ffacd0b85a97d-3a09fdd4a1dmr9155923f8f.44.1746521001127; 
 Tue, 06 May 2025 01:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiDMhadnXlOYaJ5xEfuavJo8vw7nZEiHjwTv+Tq5UxC56UVZ3eLALrt3JtU9sjydUF3V+WLW9y290yBpIHtYY=
X-Received: by 2002:a05:6000:40e1:b0:3a0:8330:3377 with SMTP id
 ffacd0b85a97d-3a09fdd4a1dmr9155901f8f.44.1746521000760; Tue, 06 May 2025
 01:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <aBnOyhMawDaY9yyR@intel.com>
In-Reply-To: <aBnOyhMawDaY9yyR@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 May 2025 10:43:07 +0200
X-Gm-Features: ATxdqUHO5kpqk7uzEPi6cWB3B3K-nU0GrrJIxIolqd-_gn_BqIv_jzcaTStcGG4
Message-ID: <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 6, 2025 at 10:35=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> > This series does not cover enabling the newer compiler in CI because,
> > while both Debian and Ubuntu have a new-enough Rust compiler to support
> > 1.77, they pose problems for this further bump.  For Debian, the bookwo=
rm
> > release probably will not have new compilers and is supported by QEMU
> > for roughly two more years.  For Ubuntu, the situation is a bit weird
> > because while Ubuntu 22.04 had new Rust compilers added until the summe=
r
> > of 2024, Ubuntu 24.04 is not adding packages for new versions.
> >
> > A possible plan here is to split the configuration between "enable Rust=
"
> > and "enable all devices written in Rust" as soon as new devices are
> > contributed that are written in Rust.  This way, the C versions of
> > the pl011 and HPET devices can be used but the new boards/devices would
> > only be available on Debian or Ubuntu by using rustup.
>
> "enable Rust" supports v1.77 and "enable all devices written in Rust"
> supports v1.83, correct?

Both support v1.83 only.  However, if Rust is missing or old, "enable
all devices written in Rust" will fail compilation (e.g. Kconfig would
fail for ARM/x86 targets due to unsatisfiable CONFIG_PL011); "enable
Rust" will simply pick the C version of the PL011 and HPET devices.

> The current vmstate builder is excellent, but I'm concerned it might not
> land soon. Can we find a compromise?

Do you think the above would be a good compromise?

Paolo


