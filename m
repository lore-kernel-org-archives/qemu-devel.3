Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSI9v-0008S9-Ea; Fri, 12 Jul 2024 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sSI9j-000811-DP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sSI9f-0007A5-Ji
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720797949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/02T7iSjsGxGmW8roHjHoIG0N9jZYbulw8XgJ0wbJg=;
 b=JkZyTsR9jo7m23j/hMfulVyc7KoQSCU3dj5P3j0a0Fmj79nEPkkPhsfbezThKtcK5ddNBP
 +WjC5MMS1fp1/XaCqwOdAvKGCy4FabH1qDbsf/DLkKe8qDiTfLtgHE+w07MgnVUtCaNB/f
 RWxOIVHV2CzYamrZpIAqZn5mefnRBfA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-_X_O6qhHMrCPrW_p3mcQXw-1; Fri, 12 Jul 2024 11:25:46 -0400
X-MC-Unique: _X_O6qhHMrCPrW_p3mcQXw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b5d34efdf9so2606756d6.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720797946; x=1721402746;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/02T7iSjsGxGmW8roHjHoIG0N9jZYbulw8XgJ0wbJg=;
 b=LrGm37DbT4boP8uwN+iLnicLs1bRL1g0aE84i1Ms3gvCbre9di4U8eSIHiRiyb37Hg
 lmFIPC69/VXchNIv/ypGIwNo4iHQaiT8HJ5iMPFvKABFEIonT/za8Q317xvHjJ+cnEII
 JATH4qbMdMg8r9n847kElOiosWnTvCwuBAteWKNsqHw/+BWPQxQgfCvE7WfLDALr0KGP
 BQnFWXrwe1vECQwu7x3/ei1bEFH3n46abJs0pRojnC2kolz/kLONdukajqKO2EHyqePl
 DT8jEROF4NwyGNAGRKJ6TcGZbqEYN3ZXCtaz1Rkipjo0/oD/wKu4r2U+aF/7lUnxx7bw
 vjaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm0kc0y1TbNXi6ZxRQzl0CEsZxQFVyK8i+00ecROA8WoKNqmRR6Fob2YMMu+T7PfC21jnwT+IsVuJoKnJ8JZsFrL/zBZM=
X-Gm-Message-State: AOJu0Yx3PaFwjt2ZH+CODAf4b3+n+EVOnoakwcMAoMhHZcaL/l1uLY9x
 W+b60f412l6RZx/J2a6d2Ka9N/xHuW1MTWI+8GQTsnbCwc4Gajbb7wVxuD+ec/xjPqjvzpC0PwV
 YT4svuDxgtSfyfICdCcV9F/oyHJLQVCt1bZGGl0LCHJ5345hTMkQQ
X-Received: by 2002:ad4:5590:0:b0:6b0:8202:5c4e with SMTP id
 6a1803df08f44-6b74b217c95mr54037686d6.5.1720797946257; 
 Fri, 12 Jul 2024 08:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1NENvl1hg/GCEbTwFOhFG/3lPDHGK5Q/GMUkO2acEp25RVptGWD44ja93bcgxMd+juNd5Xw==
X-Received: by 2002:ad4:5590:0:b0:6b0:8202:5c4e with SMTP id
 6a1803df08f44-6b74b217c95mr54037546d6.5.1720797945961; 
 Fri, 12 Jul 2024 08:25:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7544607f8sm10172446d6.63.2024.07.12.08.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 08:25:45 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:25:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 16/19] system/cpus: Add cpu_pause() function
Message-ID: <ZpFK8KZcOddY2NYx@x1n>
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-17-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712120247.477133-17-npiggin@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 12, 2024 at 10:02:43PM +1000, Nicholas Piggin wrote:
> This factors the CPU pause function from pause_all_vcpus() into a
> new cpu_pause() function, similarly to cpu_resume(). cpu_resume()
> is moved to keep it next to cpu_pause().
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


