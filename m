Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7002C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAb7-0008El-96; Tue, 12 Mar 2024 18:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAav-0007s6-PD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAat-0004Qv-Sh
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vE++ACnpq2l4kPgdISccW6Kl+44m7WS4zYEt6708zkc=;
 b=fr1aX4ZvVmT1vdatnVgL96aJmnzYGr+5omFSsKV6Z56VMAt1PURSJmYYs/BLyNEmYpRrW5
 8vA5fooHL2AZmsq/MGR256d5ZNBACTCxWkyErhbrGpg4hgUyF5matE6kBCbCR9lxkdAF2K
 v/8IzxetDy0a9vzKI9aQ0fiKZ5AXx48=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-AmoocxrMME2I7yw4VuCcYg-1; Tue, 12 Mar 2024 18:27:34 -0400
X-MC-Unique: AmoocxrMME2I7yw4VuCcYg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45acc7f07cso26151466b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282453; x=1710887253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE++ACnpq2l4kPgdISccW6Kl+44m7WS4zYEt6708zkc=;
 b=quCSRddzy+cJ8mu+UMZx3crgZhjQyOqsnkh67sEb3D53/SyznKFWUx9gaV3xikqTvC
 EoMCzE35bmLsAT/dwmEl1MJfm27aEN4VlA695yxyGcunRozfT4grdltYMLV4P/fI+Xcq
 QryX6LXacolOT9HPcORT90LT+vNyWjR3+yf7jKmz1xoZ3HIhTiNSJoM9OVPFX4Axqurj
 Gclx0LW3GnrqoKGXasnuyPYWc1mxKes5oFOHxqjoTCY38PGeS9yewFTT/iiadx25beSK
 shD1go0vMNjrcjuWUTSMlzlH1WTYNmhcO+5SBjKGkR5YSDBqxJWlBw+EB15n2LmFjEE9
 p66Q==
X-Gm-Message-State: AOJu0YxMdPv1xVRvMomitwRL5WnRk+DcF52oButbpTFjjVsB+K2cbnF4
 tyhfBoMeA5UPZXhU8snJYeaEge49X8GQwcl07IpGxr+AutVQGJrSuSpbaEEgkakrUHZFahP9bVD
 PJeRd9xkyclEOt32jB95cJMQ9QslA7zM5T78z33Wa5EK3Ly0rf7BGq2eAy2YhcnrFlppS837Zdm
 0P8SpR5xce+6c5gVEXer9hgUrDCmz6S5xJ
X-Received: by 2002:a17:906:11da:b0:a44:dc35:df19 with SMTP id
 o26-20020a17090611da00b00a44dc35df19mr3401125eja.67.1710282452826; 
 Tue, 12 Mar 2024 15:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFShTwndBcRkeoht7ojHvVlKJpYFRIl0GU53PrRq7iZx6RC6WF5++L2bf/eldEvFoH2w3HqWw==
X-Received: by 2002:a17:906:11da:b0:a44:dc35:df19 with SMTP id
 o26-20020a17090611da00b00a44dc35df19mr3401105eja.67.1710282452350; 
 Tue, 12 Mar 2024 15:27:32 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 s19-20020a170906501300b00a433f470cf1sm4252067ejj.138.2024.03.12.15.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:31 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 38/68] hw/vfio/iommufd: Fix missing ERRP_GUARD() in
 iommufd_cdev_getfd()
Message-ID: <ccd1fd0c5d4f4cba7fa8642ab466a82db3e9f093.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in iommufd_cdev_getfd(), @errp is dereferenced without ERRP_GUARD():

if (*errp) {
    error_prepend(errp, VFIO_MSG_PREFIX, path);
}

Currently, since vfio_attach_device() - the caller of
iommufd_cdev_getfd() - is always called in DeviceClass.realize() context
and doesn't get the NULL @errp parameter, iommufd_cdev_getfd()
hasn't triggered the bug that dereferencing the NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
iommufd_cdev_getfd().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240223085653.1255438-7-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/iommufd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9bfddc1360..7baf49e6ee 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -116,6 +116,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
 
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
+    ERRP_GUARD();
     long int ret = -ENOTTY;
     char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
     DIR *dir = NULL;
-- 
MST


