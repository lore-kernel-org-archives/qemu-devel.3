Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A889CCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNuP8-00037L-Ez; Fri, 15 May 2026 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNuOw-000369-7b
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNuOu-0004cR-36
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778858670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfLEXrNN3QnILOqhrHKxjfKO8vxTkOGJdpwSA53r3R0=;
 b=eE3uXck6hb1Q+iynVFs1rnyfUfWes7V1A/33klPMwh63oE3039posVu+lBZosfNvHF9w+0
 w5+yPuuKmxBcBuKsLAM6H9Gx8ug3d2+T1hQoj3I1quaJ8SOAGmcjsimd8BPLklv3+4ydlw
 ek6/MgoHJ49DtkqGzuqTuJ0va9LkSAo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-QR-Qlv-cN4mulRkHTKFUDw-1; Fri, 15 May 2026 11:24:29 -0400
X-MC-Unique: QR-Qlv-cN4mulRkHTKFUDw-1
X-Mimecast-MFC-AGG-ID: QR-Qlv-cN4mulRkHTKFUDw_1778858668
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50f13da9684so88523331cf.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778858668; x=1779463468; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mfLEXrNN3QnILOqhrHKxjfKO8vxTkOGJdpwSA53r3R0=;
 b=kR+rgL2soozRZJk/HUFRJXe4wZ3EeDlJ77i/xBH5iiYGJ/H924PH+2HYmOen8erpTP
 p3BFuZ3VaFbcbh+GhdgBiYKwz3AcmSHprFfKugnP+TF2k+KErNEOn8GvPHhf/Q8zIQ51
 MV4X7085+0NlnNX4TIRHcIJ71Sez7I56vmNQkI5O7K/qgKPg4gE8YIjamPcc6xfwt9RV
 s+Le3/cWwwBz9ccK8atAn6nsHU9sWvfIH7Xs3jQwgkgWX6dlTExY5ZxpcuTQfmMB9rc8
 4Ht7y7JNTbMbMpeWE2eByLpUB7U1Z5B/Wx1QtlRUBb7qH/dilQfBmdwsEOBKVk1aftlw
 9vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778858668; x=1779463468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfLEXrNN3QnILOqhrHKxjfKO8vxTkOGJdpwSA53r3R0=;
 b=kUS6qftk0LMiL1iNjiLa5zKVY+lfg8clTqLtqnuFSAYKTBRFA+OZFhENFTvjPBD8lI
 /+dtYeoPpD1P6UT3bolShr/S7Jd2PUf5cZlLloZAGjbtx2lG2UcqaqLSlns0HZTeC9X7
 5d84QSfQKMlCrhNmc5zl73Ebb0izPIU/1cnouBtRaGI8ozCqUgQSOrshWfCgAXNrJW0d
 bgf0dL/e2h6d4iAunjKJ66IsMFPvoQyRU0DbAoSDecIeraI+guZPzj5wTFhnnhQLNqni
 jcm9b0MRDK6SMFfiIro3QSKdPonluzO2nzASWt3lzM9hJv/ULuiU7jJTyGpyfQz4FLBq
 ubyg==
X-Gm-Message-State: AOJu0YxMrEJ5xR1jeEQpcHUadE7kuHKrfguWhPmKJWzoqBlDQSBbiHE8
 vNGf9JfRBZ+edzkwn3G6LSjb/piNOcMExvSQMH0nB8fhJe1wL/3g7nL4jcL3kYR/k0cvHUMNizi
 +PrTyu6HAI0Gq629PPLgW9AStU99JBeCypBnMLzBEDwL48wR4ZPef9JXI
X-Gm-Gg: Acq92OGXUh211PK7wzoMdFt0Af0Ch+bMOZH0owugBXf1bzhmYxsORcs7japxMehDj0u
 LOMa5X/l9C4Tu6qdeJTfhGmp0CpTbRK5hrng5XnKRZBCEAIjijuUuVe6DcRfTTuY+zCXNEnqWL3
 dPsIwcFAP/Efbv8ZD6oelHG61V6UUlLk1HzyiXGEK9yOSKw5SNkgnJMGBpCq9DCryttYQoM+5sb
 bzQvqr9jq9dF59SH4C6mFDtqFOVhHAfcJh0ckFNahWvi9gYJh/nymAUbx5ZTPyINh7I/jFuCD3z
 cJiepMMxbtxGO0SN0IxtGPhPyriWkGduyJVGs9V/z4WEUTxP97bmupOs5v36eMETlvqPt1stB4V
 NZWm8pB/azehhbZOncL+jy90d7KP5RB9hl/rj9jlXkiPBIruAqrKsKtpy6Q==
X-Received: by 2002:ac8:580e:0:b0:50f:b465:94ae with SMTP id
 d75a77b69052e-5165a1db136mr61105301cf.29.1778858668303; 
 Fri, 15 May 2026 08:24:28 -0700 (PDT)
X-Received: by 2002:ac8:580e:0:b0:50f:b465:94ae with SMTP id
 d75a77b69052e-5165a1db136mr61104551cf.29.1778858667690; 
 Fri, 15 May 2026 08:24:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516456889dcsm49549541cf.2.2026.05.15.08.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:24:27 -0700 (PDT)
Date: Fri, 15 May 2026 11:24:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 04/14] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Message-ID: <agc6qr5vl_LPAzIp@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-5-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505081423.28326-5-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 05, 2026 at 11:14:13AM +0300, Avihai Horon wrote:
> Pass the device name that approved switchover to
> qemu_loadvm_approve_switchover() and log it in the trace for debugging
> purposes.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


