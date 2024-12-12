Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD9AE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfZt-0002In-0d; Thu, 12 Dec 2024 04:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLfZn-0002H5-Jf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLfZk-0006Yi-Iw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733996019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yiIM67NB2mLW6gP+ZHVrKpq+a52jW9Qr7upW40i+TRM=;
 b=P7Ed50Vp+M3K0lgmpc90DCWKD98z/0pg/jCJQVvJ4lHIdTUFoYaB4DDNJzGnDuuc8mvFBO
 8rDNWd6mdLnSlhJcVhRXdJ66elZtNFmvRCBDk3HSMOuEAWKdHuWLRBM8DuQKOMMbWaGqQL
 9CCObmmcN97fOafK09QtVodlgl5otPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-yd0p3CVGPYqVIqF8dBkF8g-1; Thu, 12 Dec 2024 04:33:37 -0500
X-MC-Unique: yd0p3CVGPYqVIqF8dBkF8g-1
X-Mimecast-MFC-AGG-ID: yd0p3CVGPYqVIqF8dBkF8g
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436248d1240so2411595e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733996016; x=1734600816;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yiIM67NB2mLW6gP+ZHVrKpq+a52jW9Qr7upW40i+TRM=;
 b=r0r/QmKqCRL+/KjO5pHUgTxYdSioAMaJhE5IuxBtJQP2DiUSkUdzOIwyE3sUbLJ5QH
 2tyLTsldhz9g8KNihu5JNl7c4+nbW2CO8Q81IYm+cSYwr2jCCilrFDMvXmBB+A1D2zHg
 2DIdSfom/u/93TlgRYqBo6KHz24pvXchxVrg5j9+sqxBjxxaxiAERA06hHFpS6zUYefi
 gRvmMxecpA3JjsrWXq6vEkW+qlxIqam5nIM7VRoXjNGtIOihi6BUHcVgLuVeV+AYk2+6
 ZKPk1AwTQGtH7zwwGGft/sbcHexMBDFjFN/OuoeSlaGbOrsjOwE8sKEs9FKhqLdg6QYM
 Akwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX3zfkhiLXPlT+WcSZFMFd33NFWFaqphi5vAwPPCNoFMVwUwl1iDfv7701JtR43N93vrzstUxCQki+@nongnu.org
X-Gm-Message-State: AOJu0YxryAmRDj9vg5eGdCfTr5lBDFLcN8bkLcbg3Scd/NiBMCJliLvA
 xMFgTOgLebWQkPMeFpznN3CvlvV0PbmzGYBfidWLUUu7t1BOn2IxuZ6mcPMxOWackDj9KPSfEEl
 WdiBxfhO+wzLY4Rp3d1tYHMvndy6hA8PGmlQyYJRTcgWkWaQRKYyA
X-Gm-Gg: ASbGncsoickPDhgnGSbljli3LvAhRg/XkHOySfJlPGWbWf90ruF9xvVVizHTLikdu+Z
 sRpYYQLjAOedn6+mxenEgFZ2I+IdCkCzVBQqVkttnjgfSuSqAzJaWqb9LrpMqhKm4C9v5xwy8G5
 Oq3Kcp4mhu1RKfd8u35171/ztmXAAAe21FHoAOzgQ4Hnl2wydyjBWTeB9HBmmxrpQ97TJ+s1H+S
 E7EGENGrZOfy4wGh67Ktmw1m2H9qiR0GEQFcG1R1I/Tuv0sMt8bxkCJm6EPrTdek9URmPJNFt2Q
 rNKx5Q==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id
 ffacd0b85a97d-3864ce86740mr4346054f8f.4.1733996016111; 
 Thu, 12 Dec 2024 01:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmpQfrllvCOB3PPukKyhwQ7o6rEzQV6j4Pc3p0+9nDHM2+PilbTEmjSWx9mV/7V75+7HQTqA==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id
 ffacd0b85a97d-3864ce86740mr4346029f8f.4.1733996015744; 
 Thu, 12 Dec 2024 01:33:35 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251dd5bsm3466346f8f.99.2024.12.12.01.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 01:33:35 -0800 (PST)
Message-ID: <ff5351d2-be1b-4b40-b6d0-43cdb10fb29c@redhat.com>
Date: Thu, 12 Dec 2024 10:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/31] tests/functional: switch over to using
 self.scratch_file()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-14-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> Replace any instances of
> 
>    os.path.join(self.workdir, ".../...")
>    self.workdir + "/.../..."
> 
> with
> 
>    self.scratch_file("...", "...")
> 
> which is more compact and portable

Looks much nicer, indeed, thanks for tackling it!

Reviewed-by: Thomas Huth <thuth@redhat.com>


