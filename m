Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118DCC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIMf-0004c4-Kt; Wed, 28 Feb 2024 06:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfIMd-0004bX-HN
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfIMb-0001ra-VF
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsIL+g4vJ0s/atDlijImMV2ly2pFzcS78320wNPu75U=;
 b=Iy2yDQ+6jXvx5IhIDzxqx6vVO57QOLrKLgui1d8phFrVTq6+0LTY++Wz4SXLp0GLNuNbYI
 8AvlxsPj708ORU+QmSB/aNGatPnOGjGf0q7UUh41rsr+Zvu5ZlutS8Ew3ZIQFUxcJpmnJg
 RVjLg9lb/AuK+ETjYQHeVbnp2kUJOeA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-J3glfKgDMu2lZHzv0M_4ow-1; Wed, 28 Feb 2024 06:44:39 -0500
X-MC-Unique: J3glfKgDMu2lZHzv0M_4ow-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e50831226dso2891628b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120678; x=1709725478;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsIL+g4vJ0s/atDlijImMV2ly2pFzcS78320wNPu75U=;
 b=RLUZlw7ftAr7N1VR1YzghOISedvpjxjCQf5IvNCc9xH5iWVZdCuc0sxNhJrFFTm/dy
 h0WJ0S031QMT0jqhuFcNyrbHF45B+A3mLEjOYRIm4iP21R5ZGJG58+sJw+tDTjpgczTM
 h4I5jVN6oJFI7VoDh9D6jXDlBQAxF/ugWweb2K9LCZ8XLKYfyo+4nqulR9w/cax/LzWA
 7jrU9jNNbF7ciyH97bK3HrbIJU6LPZtjZypXSiUOq4aNhu55gEC2O29jFMQC0iO8FTwa
 th6C/J8btbQkGWXPYgx5JhvkMpOpZsTYMGWafSrZ+sM1gwnk59qiUr90gQZLw4Cb+pOu
 miag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBH80zF8TvQ7w9ueATXNhWKgI8HeAeUqQ3AJONrv44BCJ2W/7nx2YEePa6NCFOp2nOK8tSeMn3yx/YSjk36KUeoTeVJzM=
X-Gm-Message-State: AOJu0Yz94lVacGDlejDSntpJYxNRP+FMABqu7bF6mhl6w30YwKWOeP+e
 prxD73rVb6uhjkY0f3xi0vgfNJ7dEqNnf3gPz8pKGcOoVuKbBN5vWbWh3Yp0bbNjrjQxH1LqAcE
 5PV/CvzSgnFH3AqqvyNLZ5hFRuxcPUotkmzlJAnHvBot8+Rx0v/+1
X-Received: by 2002:a05:6a00:2712:b0:6e5:5d44:e8bc with SMTP id
 x18-20020a056a00271200b006e55d44e8bcmr1645493pfv.31.1709120678570; 
 Wed, 28 Feb 2024 03:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCZQHJf/MNEUIZpHxhBesleSFbGkoCYdDcURPE0fP5HpSZtYVbETEmJs9PNvmDE1nS3hI+/w==
X-Received: by 2002:a05:6a00:2712:b0:6e5:5d44:e8bc with SMTP id
 x18-20020a056a00271200b006e55d44e8bcmr1645478pfv.31.1709120678226; 
 Wed, 28 Feb 2024 03:44:38 -0800 (PST)
Received: from smtpclient.apple ([115.96.143.215])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a056a00098400b006e5619b2f83sm1180994pfg.7.2024.02.28.03.44.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:44:37 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v4] pc: q35: Bump max_cpus to 4096 vcpus
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <y2jzxr5fy5p7s5ky6nu5c4gk5reeofc2xo5lnnpt345iq2brtp@5qrthy4nlbi5>
Date: Wed, 28 Feb 2024 17:14:22 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA28177D-3FEE-4DD6-B7A4-2993F77F2389@redhat.com>
References: <20240221140227.3886-1-anisinha@redhat.com>
 <y2jzxr5fy5p7s5ky6nu5c4gk5reeofc2xo5lnnpt345iq2brtp@5qrthy4nlbi5>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 28-Feb-2024, at 17:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Wed, Feb 21, 2024 at 07:32:27PM +0530, Ani Sinha wrote:
>> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to =
allow up to 4096 vCPUs")
>> Linux kernel can support upto a maximum number of 4096 vCPUS when =
MAXSMP is
>> enabled in the kernel. At present, QEMU has been tested to correctly =
boot a
>> linux guest with 4096 vcpus with edk2 pending various upstream EDK2 =
fixes
>> which will probably be in the 2024-05 release to be released in the =
coming
>=20
> Merged meanwhile, so 2024-05 release is a sure thing and latest edk2
> master branch is good too.
>=20
> You might refine the commit message saying so.

Can I refer to your two pull requests=20
https://github.com/tianocore/edk2/pull/5410
https://github.com/tianocore/edk2/pull/5418

In the commit log? I think they are not ephemeral.

> With or without that:
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> take care,
>  Gerd
>=20


