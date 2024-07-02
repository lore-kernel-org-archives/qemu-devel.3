Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F994C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 12:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOcRS-0005pM-7q; Tue, 02 Jul 2024 08:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOcRQ-0005oz-Vc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOcRP-0002Hw-Cd
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719922618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpKcR33Hbz7dzWbj3Y23KD2bA82BAS/HKvKJYEpKyHk=;
 b=B/wOn02Hrfd2ZAxflAtcHspDCbMRUOfIJzoG7z7Zv0wbZV7q5AHYtc5wdEG6R1wpDFn0O3
 IOcZuxwD4pxwfHnUSbXkGfCIBCWRZqWAfWrivwZzL5dT1rn64OJTIxBku7LafezQzkzX3q
 xNUXamC6JMLun/rL8hL9j6aZSQAp9VE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-pvDFNOpwNL2FxITz76Pv3g-1; Tue, 02 Jul 2024 08:16:56 -0400
X-MC-Unique: pvDFNOpwNL2FxITz76Pv3g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36248c176c4so2664815f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 05:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719922615; x=1720527415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpKcR33Hbz7dzWbj3Y23KD2bA82BAS/HKvKJYEpKyHk=;
 b=TcMCcg8jBcc6UiTfE62K0Kub/SKoHPgWX8ko29BNthX+xGu56Sh/gMMbbG/u6mQHFa
 6whXbb2VwC9G6yXkPAt2Q+4UTpDjXuLPCqp4RbOvcdfECiH9LN2jVAHOXTMkLuIkq65e
 55+6kc1ktOqr973nSV9+lpXF5dgR+mdgIBEnnmlT+15KtpO1+WbTHEU2EjjuyIjkNUo7
 BsnkcRry26tFkaNZiDm1eY/SfYtFcE0O2BC0kOccR6YVtTHwU6Fn/BqosnhMSE4qzfdh
 LpjTR5VGao9sfTK4vNLszoworiNFt2Oc5PZ5Id2bOIAJj+jRBxPn3nl6g/JIklPlzRXJ
 9KWA==
X-Gm-Message-State: AOJu0YwOwc/hWct0mTHpuEvg6V/1gWPy5uK2GTZlcL3Uv/uYpnmMvRIz
 XhfRulqQd/Y6bYPUF1XxfDV0/5nefcYMjUprh6lz0t1Qcdioyn9nQI6inG/4+fESMzgCf/tvcL6
 jyuK9BOLJWsUNMpwouv0OrTYHKJ3b5g3dknm2PFw/1jNUkuj4PSyM
X-Received: by 2002:a5d:5262:0:b0:367:200:28fc with SMTP id
 ffacd0b85a97d-3677572845cmr5026623f8f.62.1719922615321; 
 Tue, 02 Jul 2024 05:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAhmWmvYCz6+2e57CYR573DeOWPEHMs+Zp9UqU90xOpRhdA9A5RYnto92W4GDZU09EXK+XMQ==
X-Received: by 2002:a5d:5262:0:b0:367:200:28fc with SMTP id
 ffacd0b85a97d-3677572845cmr5026593f8f.62.1719922614495; 
 Tue, 02 Jul 2024 05:16:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d00sm13115496f8f.99.2024.07.02.05.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 05:16:53 -0700 (PDT)
Date: Tue, 2 Jul 2024 08:16:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 Clement Mathieu--Drif <cmdetu@gmail.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Message-ID: <20240702081539-mutt-send-email-mst@kernel.org>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 02, 2024 at 05:52:29AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clement Mathieu--Drif <cmdetu@gmail.com>
> 
> This series belongs to a list of series that add SVM support for VT-d.

You don't need ats_vtd as a tag, I think, so if it's helpful
for someone, I don't mind. What you do need is "repost" so
people know how it's related to your previous v5 of the
same patchset.


