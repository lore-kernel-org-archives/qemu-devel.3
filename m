Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C822EE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 06:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXE2f-0006kV-DL; Mon, 13 Jan 2025 01:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXE2c-0006kF-Dj
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXE2a-0002sL-N7
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736750111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DEMCnPk7bYarjCEcmDkxcRFLLVWc6Hx36NE/oxI7FVA=;
 b=J5Aphfy9rRhF1efCcsLw3uTOm4yBjLePajD0viCigB0SkoB+FFZxaADA0KqgLtS2GKsQFy
 QwhFDHmHESA2sigpqQgVFTha2Y/gW/0MX9EyyoG3rFfZco5t5IWVSCKHI1eY+4PWowHMkT
 8W+9USlcdl+baFaD+n9xXSP+ibzuCxU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-HZX45jiZNSeJNo4Qnb36qg-1; Mon, 13 Jan 2025 01:35:09 -0500
X-MC-Unique: HZX45jiZNSeJNo4Qnb36qg-1
X-Mimecast-MFC-AGG-ID: HZX45jiZNSeJNo4Qnb36qg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d0b5036394so4269359a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 22:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736750108; x=1737354908;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEMCnPk7bYarjCEcmDkxcRFLLVWc6Hx36NE/oxI7FVA=;
 b=sVAHhigzY+cOj3/yxdBvfs4sWDNkBjx7Uwd7RnZ5CWQV4FV3X1n5xo33nBQ5tqGWsM
 WHL21xSuZgpPUkenVfYmvaLOhv+u2rDIx0JP2HlvB+fwcKGfj8DXTwL+WGWp4gvkY3Ab
 4EzeOVtBD8wpfK3WTcYCrn2LfBKhotvOQyP8+qxPGaHqY80M+BWuVTSvbwWK7jiyqkQw
 sG94TN+w2Uo8sf50PCe6WeAYlMczpNI4eNm5UvOqR6T2aj8whhy2SQy39N65M6kbhZT4
 URnLWi2NwdyOoIGZI9+2kortLjAbqmftrJVyYxalq+SCwKOxYd58IApsvOsz9EroUWgH
 Ecsg==
X-Gm-Message-State: AOJu0Yyo2UFnHZtdjilE1AQyqei6o3MbxmdYogJSQOacui7BT0gGc70D
 7A2uGQgafV0lpo2VVF2Aef6akvkXOeCbUzX0lQJQKZeFhw0/jc4H1kQs3uxji6bf986rbWmHjZN
 Sauzgwc+iWl9itOX1V+broXCsYaLNpo5AI3QUGrKRBfmEzngqWcFM3krJ2yhIVosjczjd0l+I/w
 d3a9Ty28lSVvNdxVYzxJZf5tz8J5bw9vU4
X-Gm-Gg: ASbGncsLcyg0i0pTwLawgMuItahaX3tD6pOswR5lVErEnDeXfHf6cdxrmG5IaB3K4aK
 yuFdfuYC7TDhgvta7F58cEvbOjj9WKsF9cpZhDo5SQQY+y+Oizr5gqRdHR52FrAaQYouGOYnqAF
 nJRKf8T4QKXrORzGAky3ZboIM2X7OamUnAg1UftHbjqEewpTNl/8h5NHhBOhKMA3QOboi3Vn9Wy
 H1l3FqXed7wBjKClT5e2ynKmg8KxE4m/hcqW7mORTLWyS82oXG5EegqXsPEWYONQCiLSTyFhKEU
 HrfEo0j3Jg==
X-Received: by 2002:a05:6402:34d2:b0:5d1:1f2:1143 with SMTP id
 4fb4d7f45d1cf-5d972e1a602mr17886220a12.18.1736750108130; 
 Sun, 12 Jan 2025 22:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG1hkyp7urOnF5im6752+QUY3dGeg7/V+e55tlJiK0jTq89Uz9I8ZzhkSHe7ZztHRWcScxgQ==
X-Received: by 2002:a05:6402:34d2:b0:5d1:1f2:1143 with SMTP id
 4fb4d7f45d1cf-5d972e1a602mr17886205a12.18.1736750107809; 
 Sun, 12 Jan 2025 22:35:07 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-16.web.vodafone.de. [109.42.48.16])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c362csm4331431a12.19.2025.01.12.22.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 22:35:06 -0800 (PST)
Message-ID: <3debcad5-7740-42fd-b773-a5c54f703fa8@redhat.com>
Date: Mon, 13 Jan 2025 07:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: download.qemu.org file list
To: qemu-devel@nongnu.org
References: <1fa-67828900-3-616bbe80@197637592>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1fa-67828900-3-616bbe80@197637592>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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

On 11/01/2025 16.07, Rahul Chandra wrote:
> Hi,
> 
> I am not sure if this is the right list to send this to, but the https://download.qemu.org/ download server is showing no files available for listing. Is this unintentional? Or should I be querying the Gitlab tags from now on for version info?

It seems to be working right now ... could you please check again?

  Thomas


