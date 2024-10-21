Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB44D0E6D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2o8v-0005bn-Uk; Mon, 21 Oct 2024 04:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2o8u-0005bX-EP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2o8t-00070M-40
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729500717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tUuGIxvhhh+93AtS4k0Iha8XKdOiYKrLcao5rXJEsk=;
 b=H+3CiRtVhdE4Dmx4GwQoaL0ioEJXnxx6ZVfir9cFAjpAgtHxRdHe8FvhrKTBhcgYP8+ka+
 XT+M3cL8j2tffEYQCkyiyijZxaup/+UuUKX/2byLjVR+42AVdw0BSqDvilPKf/qxxtbzuQ
 O1PI9FJgVsYFft/o5lmm9i/BbMmJUwk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-eHscDzSNPDydzd2oaatOCg-1; Mon, 21 Oct 2024 04:51:55 -0400
X-MC-Unique: eHscDzSNPDydzd2oaatOCg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso2289992f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729500713; x=1730105513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tUuGIxvhhh+93AtS4k0Iha8XKdOiYKrLcao5rXJEsk=;
 b=DzVtvzrx25+t7ezKnDBTiS7rkCkthGtCEqkbOvjRM9IY0y2YEzDD6IaoK6VxUeSPCn
 zRrkkPmPefKLaW1h5gKQYmyTPsYYwCkPfxvYQrgg/do/BlIIUV7idppqS1DYQAdji1n7
 T7yMzKhkDEVqtQbIxHiL2U/L6YbpOZ4SV9bMtLtBv+WZPF9FXlzCgzvhb5Z9F+1Lg0zC
 2eTaD2c1cIxM5p0MiQNoan1csMxGuG2ViIKfAx+qiyojz7IBjuWCC6fR58pwbCF6IkWP
 3YlCWLXQsGG9RYhzZ84+D/7uJhKiP4tafTfNK1+HUqPDxZLNOxFV+7uZxZUbovA3Y+dJ
 S4nw==
X-Gm-Message-State: AOJu0YyqLT4anYUI2huz3CK8/KgfyWBG5iPSpkNwIz6vvU098iqizVZ6
 H8yql5wl9l73JqsCXZL3CV9fBtICUKOZ4SOC+HO50/dTGoxloXmrZgg1HXSgODs8K3DAeHiUPHk
 6GH0FaogQ2C4p+wgD9wTYHwyHoygUz/1mdiIU/6JpLlpzj9URwLAfQmO/GWbjtgIQRmIoqdFyEh
 sAcae/Ypph+X0womvSY+VS8/06my59krHplUFrTQ==
X-Received: by 2002:adf:e791:0:b0:37e:c4e3:f14b with SMTP id
 ffacd0b85a97d-37ecf066151mr6153016f8f.23.1729500713466; 
 Mon, 21 Oct 2024 01:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoQ+RxAxcP5rPnvdfO8uxh+OYTPlRF+O7c2jsB0vco43hvB00SPeXnFlMAb+xDL8hJt0xs5/LT/ZYsc58/3Fw=
X-Received: by 2002:adf:e791:0:b0:37e:c4e3:f14b with SMTP id
 ffacd0b85a97d-37ecf066151mr6153007f8f.23.1729500713191; Mon, 21 Oct 2024
 01:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-9-pbonzini@redhat.com>
 <ZxYZtTtZbDRfxuQk@intel.com>
In-Reply-To: <ZxYZtTtZbDRfxuQk@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 10:51:40 +0200
Message-ID: <CABgObfYruAZAgNEnpm1+8-EFCAsxvNOkQk9Jjh=xF5WrkUe04w@mail.gmail.com>
Subject: Re: [PATCH 08/16] rust: build tests for the qemu_api crate
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 21, 2024 at 10:50=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
> > +rust.test('rust-qemu-api-tests', _qemu_api_rs)
>
> It seems the change will bring a warning for "./configure --enable-rust":
>
> WARNING: Unknown keyword argument(s) in target rust-qemu-api-tests: rust_=
abi, prelink, pic.

This is a Meson bug, I'll try to fix it.

Paolo


