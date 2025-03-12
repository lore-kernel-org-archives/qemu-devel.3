Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA0EC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 06:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsFhy-00032v-GA; Wed, 12 Mar 2025 02:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFhe-0002xN-Rq
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFhc-0007XE-Pg
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741761386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vj2lChn4/Q4i6rvmIMfZbwZgPNys4pp68QRB91YsLuw=;
 b=cSrK6xXKl49mTE2JTDAXICeoKBNOPEY9xHrvB5UcMY8T7LYP7w5f2UhtQkUSIdPLjq3IPs
 bogUM0dA19w2m8mYYUZiM0JGaekn2lHBSSZYTqEPf1p84+o54xVDl6hzVkI3nWDB0sCgEh
 Mddvg8VUeOjFqJfsNzdJkZYOCvLU83Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-DfOkhIp4OGqfVRhrMrQteA-1; Wed, 12 Mar 2025 02:36:22 -0400
X-MC-Unique: DfOkhIp4OGqfVRhrMrQteA-1
X-Mimecast-MFC-AGG-ID: DfOkhIp4OGqfVRhrMrQteA_1741761381
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso3798543f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 23:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741761381; x=1742366181;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vj2lChn4/Q4i6rvmIMfZbwZgPNys4pp68QRB91YsLuw=;
 b=FrBDwpZs99G9/BqNFkYqrcX7czaVpL+tjrbF6deKiWvkveSzvQU9qM+RlcKcpXR7Am
 5yOXjEaRrwz6KauSDDPDTii9EEZ8/+BPuhd3Ipwmv4Ui1VW1c6j+eCPe4ImnMqiPy1p+
 2hjya3/ONrtBc2xnDHSCltK84tOrLUOZUrwBgfALHiIa4cBFy5SY+w6+/dd3vgbs0hGR
 gPILZJAaSXChcLvkBaWX1PW6o/J6VK2td6K4TA5AeGsZ/48/HeERU8zPvUNWHD1h7l62
 OKEo8s9k+aHhwUIc1GZGKV894U4fKPTMGEffht6uLYIIlAP1u2W21TA4Hj5G00P6bxPh
 Fl6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq710VEhWnVdDV0VT+swBR3g+I7VohNZrwoxsvgco9X4u0DblKHhpHXMmsvd+rqvwZTNYDKvkI6Xp6@nongnu.org
X-Gm-Message-State: AOJu0YzVnVl9AoxUcjRA811EO33tynodALN3jDMh03gVVmwlZZp1lffj
 qHwrSFbuxqhpynL0e/3fYT3hl4pzfwhV1oGeGeKXyEoWgVRwosOBagPqRvZhFeq6E1SdlORfozo
 dmQSwA+9xfMFiY278tvIIuaHJn/K6+rMjXfyFHu4zDl/U2sdh6Zqv
X-Gm-Gg: ASbGncvE4c2IUQlOb4aCcJNE6/2P0qY03sl4vYPaTvf9hBkX5fvZav3yochWqT9xW0Z
 b7wGNZCeyIX10dpSGFT44SqDy8IJ9BFLLl3/3GtSmM9E8H5pi0isL7DrRDcPlNUOLtmC9OIgoPH
 fbPlbXt286KR7nYwBazionz/lg6HmrXiK3B+QXTWBWAcwqmI9w+IVrfXd3CPUj5+oU7g0pnMHhH
 lsxabWfv8p6jL7aX2ayUYfP0VyR1wJgsMZzDijW+UhD3QASfIDmT/4swt1rVkIFFbBIt+O1PAhz
 6KaPBXWvZw6GTn8Lsz+9+zS5RIrycGGPopK/+92dR8Xdngs=
X-Received: by 2002:a05:6000:1564:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-39132d7b834mr15442392f8f.26.1741761381160; 
 Tue, 11 Mar 2025 23:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYE3+HX5PyELunR7CiTe7+PIYTJPLemE0c/hfCxcn5BJ+guQPwEp0COhNSCCoubqoIKS1vlg==
X-Received: by 2002:a05:6000:1564:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-39132d7b834mr15442382f8f.26.1741761380858; 
 Tue, 11 Mar 2025 23:36:20 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfbb4sm20519568f8f.30.2025.03.11.23.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 23:36:19 -0700 (PDT)
Message-ID: <45d36146-3d2c-421e-b58c-0b1ef50ee81a@redhat.com>
Date: Wed, 12 Mar 2025 07:36:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Don't fail any precaching errors
To: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250311131327.903329-1-npiggin@gmail.com>
 <Z9A8swNn6zBm57jC@redhat.com> <D8DU1X7UDEPK.2PZVT8SJAWUFI@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <D8DU1X7UDEPK.2PZVT8SJAWUFI@gmail.com>
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

On 12/03/2025 00.41, Nicholas Piggin wrote:
...
> I think *no* precaching errors including 404 should cause
> failure because you would still want other tests to proceed
> (in some cases).
> 
> But the failure should be caught when the test case tries to
> fetch the asset, so you can still easily identify the download
> failure.

Sorry, I did not get that... if we ignore the 404 during the precaching 
step, how should the failure be caught when the test runs? The downloads are 
disabled that case, so the test cannot know whether the asset is not 
available due to a 404 or any other reason...?

  Thomas


