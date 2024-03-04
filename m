Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BDAC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3DF-0006Zo-76; Mon, 04 Mar 2024 02:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rh3DD-0006ZZ-Uw
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rh3D5-0005iw-RS
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709539084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eq8vXfWwMyLrdO4p1AYsBmh7EtJOHJo+KKBnW/0sIOoE40Pn4BHOkWfaMDcAytOtj68vhb
 M1akUDUP6gck0xJcjTZ+KYJqggWUUrnrHVy3G9PTKiLlGQgM02IG7QEBDH4vVk4CoZMN5i
 nHHB95TMDz0higrgLj8JqbWFJhBW1lA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-FpaCTTtEPjmAfJSDC37_cA-1; Mon, 04 Mar 2024 02:58:03 -0500
X-MC-Unique: FpaCTTtEPjmAfJSDC37_cA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d32d9a312eso20246901fa.2
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709539081; x=1710143881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=EEgLASCp76zFO3muxg8tA8L9TxIhVk+lXDqjc4QLFc4g5Ky5R7mRH++TfXSVnOEuID
 Q41/Ocp56oxSVenvXsp3w5+f2YZq0cFGXRhGswdL3boBDhegP7AgehMkfMawhdQyW1Q3
 xLjdZc4vknpKw9eqDy/dxtswh3JGe3Ohds5Z+dHn31j7+ehJTucLAuM/wKz7QDrtfrDZ
 NuxSJUxpTV4Gkm3Xd2MRU0UFSyq0iTCUQoA1EgkpFC33efUaWTtmTylZYrKG2rB/mCC3
 ZD5lJAYs38Is3+BP0kNIwbeVrBh/7c2wcectmF0I0lZb8jd6BQOpp+Oq8K2ZVPCL4S9h
 K3Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9jqApkzmmhKAz4fhYPZgYvnDgyzTZ3gBmams0YGLNgxh0ZC6l5XQIZAOE8xis2BLTuYHtBoG3J/oJaOtsUIkQPTbDsxE=
X-Gm-Message-State: AOJu0YzFNjUQH2v0vb7gk1UtD3F1TVMZYciC4IhAYTNafRVKWAs8+g+r
 GnK+dq6mBT/83p8AmyGLMaE+QfFJZK1/vdAB2qmuv8KfE/fk5YMM4WVcW/MXwI5giLjdj+OUlbM
 6BUs8r8pE7c3xN/8vYP2DHavneGWd96I4Zoh9UzWSM2m4bakD0SRX
X-Received: by 2002:a2e:6a06:0:b0:2d2:6608:3d05 with SMTP id
 f6-20020a2e6a06000000b002d266083d05mr4964575ljc.52.1709539081718; 
 Sun, 03 Mar 2024 23:58:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZYTYwH7Op+MfSujuEBSrqFm+S3sWN0Tg1oc9o/br7/+Vjjzakf+uG2oj9zrEA1qyv4Y6vTg==
X-Received: by 2002:a2e:6a06:0:b0:2d2:6608:3d05 with SMTP id
 f6-20020a2e6a06000000b002d266083d05mr4964559ljc.52.1709539081267; 
 Sun, 03 Mar 2024 23:58:01 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b00412d4c8b743sm7005063wmb.30.2024.03.03.23.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:58:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sven Schnelle <svens@stackframe.org>
Cc: Fam Zheng <fam@euphon.net>,
	qemu-devel@nongnu.org,
	deller@gmx.de
Subject: Re: [PATCH] hw/scsi/lsi53c895a: stop script on phase mismatch
Date: Mon,  4 Mar 2024 08:57:50 +0100
Message-ID: <20240304075753.157370-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240302214453.2071388-1-svens@stackframe.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


