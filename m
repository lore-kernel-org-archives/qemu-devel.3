Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB0BC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 15:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLPOp-0007KC-Pc; Sun, 23 Jun 2024 11:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLPOn-0007Iy-Ba
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLPOl-0006py-LG
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719157498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOQWAQV/URnjsigmAFFiO2Jhtz5otnS/vOIpDksONjk=;
 b=FV2VSZp4HmMwY0jTbKJReyhQiEVitUg+kSWC4h7qu6/bHF2ZQcN3Y/qvPzjKxg8KhOFi3V
 vo2mQd/7yaPLbGpXylhRGf7TFJG5UAOVG+7SiEkb2CeeroG3deIvI4pIeN3bjwzZZzYbpg
 k8Xndx/+fSEyh8Ub4Uz/gUrI/kbeXE0=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-qYR4yctXMCu6w4mqcIKXWw-1; Sun, 23 Jun 2024 11:44:56 -0400
X-MC-Unique: qYR4yctXMCu6w4mqcIKXWw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-25cbd68532fso821899fac.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 08:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719157496; x=1719762296;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NOQWAQV/URnjsigmAFFiO2Jhtz5otnS/vOIpDksONjk=;
 b=oHNmCMWjh+V56MAnTQu+KlNZVgIbYlljbS6lwS4Q6kUElZsgWKR/Y2LFe4oY/IjBC0
 54FiNZDceyb1OSplKvrc2qWIbQjruh+OuLzb419G9NYilaZw8iASotFnhFAvYrRaivTm
 yiLPVSowYJXG8MTB7JWbfyP8tAo5ZirJ3m00Yg4g+wwpZw2JLIPdVW9xLYeZh6tP39vZ
 FeDipXLgJOIj8jzoYj3f2rNapYazdbsbyPQ0tQ4mM2Ct+PHU4NkXNqbUqe+U2icd157L
 nDMhS3etHKi1s3MsuU/zyLabrGCFR1XWjDdjmZY1aJBJMiT4MDaY0GJH5inofPxMNLyb
 w9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMt/EwpwatdKifRvr8v17WMTWnE54HajdhanH+e5ugI+yUQGFUZ1Dqi0/Uob2PlxOyeQrfKVqMGv0rf0qDRMUY9TfAKio=
X-Gm-Message-State: AOJu0YxD2obWo3SnptxnXsVyDw1VyZ7uDZpMeyIelqCeIY1irFXgDGVP
 GLbgLgrdBC0QMlULiU0o0LllT7eVd6a9aN+Wg+Qpd/yM7bo2WYoXuuqwDH2+JJ3xyEJn1rJzOma
 p+J78HwdkSSIztCiY6KNrp/TS585yDx7V8N6gmkAkMzJb9TVWo5z5
X-Received: by 2002:a05:6820:826:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5c1e5ca2ca1mr5577642eaf.0.1719157495682; 
 Sun, 23 Jun 2024 08:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqMUcRBx2hl0U4QBFAKR2pXu+/mFazPPIeYpCXPBl1AmnaT8YQ+Cs7x1HSgCpYu3tvKWUcNw==
X-Received: by 2002:a05:6820:826:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5c1e5ca2ca1mr5577609eaf.0.1719157495162; 
 Sun, 23 Jun 2024 08:44:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ecfe6e5sm26363636d6.15.2024.06.23.08.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 08:44:54 -0700 (PDT)
Date: Sun, 23 Jun 2024 11:44:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3 02/16] migration: Fix file migration with fdset
Message-ID: <ZnhC9HT2RwBj5L3Y@x1n>
References: <20240617185731.9725-1-farosas@suse.de>
 <20240617185731.9725-3-farosas@suse.de>
 <addd7e3d-c56a-4e4d-abef-52243fe6120c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <addd7e3d-c56a-4e4d-abef-52243fe6120c@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jun 22, 2024 at 07:21:52AM +0300, Michael Tokarev wrote:
> 17.06.2024 21:57, Fabiano Rosas wrote:
> > When the "file:" migration support was added we missed the special
> > case in the qemu_open_old implementation that allows for a particular
> > file name format to be used to refer to a set of file descriptors that
> > have been previously provided to QEMU via the add-fd QMP command.
> > 
> > When using this fdset feature, we should not truncate the migration
> > file because being given an fd means that the management layer is in
> > control of the file and will likely already have some data written to
> > it. This is further indicated by the presence of the 'offset'
> > argument, which indicates the start of the region where QEMU is
> > allowed to write.
> > 
> > Fix the issue by replacing the O_TRUNC flag on open by an ftruncate
> > call, which will take the offset into consideration.
> > 
> > Fixes: 385f510df5 ("migration: file URI offset")
> > Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >   migration/file.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Is it a stable material?

I suppose yes. Thanks.

-- 
Peter Xu


