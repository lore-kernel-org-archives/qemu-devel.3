Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1E0C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 05:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbR6-000848-DL; Thu, 13 Mar 2025 01:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsbQh-0007jc-Er
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 01:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsbQf-0005nG-8w
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 01:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741844903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5zKMm7uguWQ6Yl+pWXQAXrv/2tw9IZv7RzSQOxTquew=;
 b=Dy8FSchkCzfJxQG5hkGmHXwjUxvD50exLVUkInGqngDDlSlEwMmvWUxc9XPiCIbjF8zSzu
 VTZUKo73SUHqO5Xwkj+CZ4HuWI8U1CHJKPhVsz5+TInYRqAhDMLobRjtJyMlEQLQvrv3Kx
 At0YREy9iVhvglQII6SmEnSfYlpjItM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-8LXX7TFROeaNrc9Uiz3dig-1; Thu, 13 Mar 2025 01:48:20 -0400
X-MC-Unique: 8LXX7TFROeaNrc9Uiz3dig-1
X-Mimecast-MFC-AGG-ID: 8LXX7TFROeaNrc9Uiz3dig_1741844899
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so268403f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 22:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741844899; x=1742449699;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5zKMm7uguWQ6Yl+pWXQAXrv/2tw9IZv7RzSQOxTquew=;
 b=r6ICL9wMYU1NyorByFWMDvQ5/9ZKcxJJN+fh/zjuFi5ZLSO936+VOYXxz2Wo78a3rI
 AIjFgtFsKclhEO6jVKirv2lpmUiMQeVx1m7ztti4EL+VWGIw3cN41+q1rApC1iCTZYhg
 8GXvsCCiyC+qNsZQRZwSHIEnsbfaguKUiObGSunQHry61ezwC3Nu+xgMJAelhhaDnceG
 WUunGJHGRHlNIKGghFaAERMNlekooRm2RCbsq8ojS6EfUdNQByz35xeJResKS+DdgeEg
 V+4uzQ0qMH93naAUYxWbFzctnjvI9wiw6piwhzjEkKjUguJwOsQnEznk2Z7EyVptLnj3
 CRmw==
X-Gm-Message-State: AOJu0YxIVMwfjdwMICvqmlDVXxeOyi/VHqrLFYp2DHXdEXwEc7+BmYsv
 PM9MRc+YU8STC8P7ckPXRCG59I7+rvBadzReRnuI8rRc8LAp+W2o42UARMCPpGiNzGCuRwiX2/l
 1WAU6iRuS4BosuUmL2lDnPDmhIP3ogbzHj38tVCA5Xo9fFGbEieHh
X-Gm-Gg: ASbGnctTC4FZK4oABVReYdFgRs0Rob6MAyXHd7FADHXqtnPmnEmmP0ftSnlqBhPoKqp
 nu+g6ArrOtNsgtiUkZJxtwUcWzleIgi59P4T3OoZOLzSxrhxLVC09Al915ObCmMqB/lYQARBiwl
 UqDEsqIpMdDId/9lleS2sUMXafGhpguGanw4JIlqyZprD4sOURamskqIlaWqeJ+4K5HKFq9qCpg
 NZ65gv8e7MBoHoM9pLgo22Lk5YDO+sgTpoAaTVlo39g9wQJYCdG/sWLmfwcLjjMuf3xBRhgOJPU
 ccrUXWYMoLXnNadvwI7yPu8Shq1wUD5ZeOn47K/HyXC6ncY=
X-Received: by 2002:a05:6000:1acb:b0:390:f5c8:1079 with SMTP id
 ffacd0b85a97d-395b9b10df3mr565029f8f.24.1741844899184; 
 Wed, 12 Mar 2025 22:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdRgOwXv74Tr7B6fWK953WzsvzCFFZsKU5O5YXST1zxNRBceSIeYehUW8Bn1S4JSh5HFWWtQ==
X-Received: by 2002:a05:6000:1acb:b0:390:f5c8:1079 with SMTP id
 ffacd0b85a97d-395b9b10df3mr565015f8f.24.1741844898860; 
 Wed, 12 Mar 2025 22:48:18 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8d0ca2sm41239015e9.37.2025.03.12.22.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 22:48:18 -0700 (PDT)
Message-ID: <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
Date: Thu, 13 Mar 2025 06:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broken NetBSD Orange Pi image URL in QEMU tests
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Reinoud Zandijk <reinoud@netbsd.org>, 
 Ryo ONODERA <ryoon@netbsd.org>
References: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/03/2025 03.22, Stefan Hajnoczi wrote:
> Hi,
> CI jobs that run test_arm_orangepi.py are failing:
> https://gitlab.com/qemu-project/qemu/-/jobs/9390048284#L1138
> 
> Please consider how to resolve this so the CI job passes again. If you
> are in contact with the archive.netbsd.org administrators, maybe
> contacting them will lead to a fix. Otherwise please update the QEMU
> test to use a URL that works or remove the test.
> 
> The NetBSD Orange Pi image fails to download cleanly:
> 
> $ curl -O 'https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz'
>    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                   Dload  Upload   Total   Spent    Left  Speed
>    0  303M    0 2048k    0     0  1098k      0  0:04:42  0:00:01  0:04:41 1098k
> curl: (18) end of response with 315646186 bytes missing

FYI, Nicholas already provided a nice patch series to skip the test in case 
of such incomplete downloads:

  https://lore.kernel.org/qemu-devel/20250312130002.945508-1-npiggin@gmail.com/

I'll try to assemble a pull request with these patches today.

  Thomas


