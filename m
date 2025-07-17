Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CA9C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 11:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMY7-0002Yp-HY; Thu, 17 Jul 2025 07:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucMXn-0002PK-B6
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucMXk-0005hb-29
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752750769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nkqvxOw+poilH5UZuAipMzeYMYDy3LtRL2kf2P5ZF6M=;
 b=CQnuSpnJ3JDRr7Q+xrRBec9zxupo59AiOKMPlATAP+n9GGo7SD3mL47K1LRKgN6zMmzg4w
 PtpGB7UquA7V9/SgOtKC9SlpS8M3/z5gGSfJrRLcAowjgk0Mzjszy1OWKB3Aq1pwugtFs1
 yJWgL5vlvGubCLHu9DLUEauDoaU9mZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-3RBS8ascOO6EoS9wBFtGjw-1; Thu, 17 Jul 2025 07:12:47 -0400
X-MC-Unique: 3RBS8ascOO6EoS9wBFtGjw-1
X-Mimecast-MFC-AGG-ID: 3RBS8ascOO6EoS9wBFtGjw_1752750766
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so493977f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 04:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752750766; x=1753355566;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkqvxOw+poilH5UZuAipMzeYMYDy3LtRL2kf2P5ZF6M=;
 b=qs4buOMvmVqD908qiYcrALQnAqk8LoTM1v5iLPcoWQqBc9rv960TXLQF6St3StVXfP
 nRLUS8f7/GT0JxySciAEoSU2qinskvd9R634FYlwzeSGCywDnGVNiHMh9rtfilWfUXLo
 Ngq08KiayreIk9qeDFvC5cVmXUEn8iga3QwP5tKClvTsEy8YmYIAfXzDJBAYcJqvSG0D
 UWtZw63jSqpp0B1H7ePtDLFguPo6CPKVzC74x1IcRZW5JNvt/F/MumZT8xQm/X5dOIFt
 CG9lGdWN63CG+CX0gtpbi7DF8aVByfw13YVHWChpNJCTiVfA3EVD4ujFPkMycmBkH3Tl
 pTKg==
X-Gm-Message-State: AOJu0YwMzzwx6ZwG8Ehwlmm2BnrxbQ1+2VvagoH5rQLn1m1+ZuesjQD8
 RBpEy3q/xPF5U0TGo4LS3MjBso8UVONi0Khd2D/SWJskdrrd7Uh5f5ebRt9aMUKgoJzV7lKI7ma
 v5X6Jxk3TifIbjOU3mJ77kqHm1oKnwvwli1y+GL7S2nhwdh4jstBRdOKH
X-Gm-Gg: ASbGnct46Mz3KGLqg5oubBxTDGrBN7MO3YPHpmyD582n2VLDY4XpCDmJHRTc9d4DILI
 W8ifHSxAdmocW9ZGo8f88+pnwNUelRgmgRY325PcwWrclXbFiFqJS7lqsuDbPTtZx0N2ALNoWSr
 F2dP26GDp+cqnydTI7eH4aDMkGFOiaxPuZ07Pnv7CGlKhzc4ArribJlkYV4hu/C/72ySwvaixwv
 a6FtLwvuia9mItLsM08+gkfEI8ebQWBJLFo+nadCVZvkWzmDahOvl403lsoVitQLeeNzUAz74SI
 lrbQHDrEEnN//u4fK0PwQEuaKlj9zEN1TKwIl/G4oCQwDKLTaNzKOhg8VW09THdMAb4b/ubm+Hk
 rMA==
X-Received: by 2002:a5d:588e:0:b0:3b4:98f6:dd77 with SMTP id
 ffacd0b85a97d-3b60dd7a995mr5583322f8f.36.1752750766491; 
 Thu, 17 Jul 2025 04:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6EAJCYppPc/L9I/AU8SoPA8nXy6dJo6J3CTJlJMaLTO/FZwtvEYYbei7QtKGqbQ2hoDEP9w==
X-Received: by 2002:a5d:588e:0:b0:3b4:98f6:dd77 with SMTP id
 ffacd0b85a97d-3b60dd7a995mr5583304f8f.36.1752750766072; 
 Thu, 17 Jul 2025 04:12:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b600722780sm12707079f8f.23.2025.07.17.04.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 04:12:45 -0700 (PDT)
Message-ID: <e0937794-880a-4cd4-8f31-3536bcbcecd8@redhat.com>
Date: Thu, 17 Jul 2025 13:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL V2 12/16] net: Add passt network backend
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250715043524.21719-1-jasowang@redhat.com>
 <20250715043524.21719-13-jasowang@redhat.com>
 <CAFEAcA9OydUfi-sz+dEJ2w4OiudM-9bo6jNk+_zacyj9bos_-A@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <CAFEAcA9OydUfi-sz+dEJ2w4OiudM-9bo6jNk+_zacyj9bos_-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/07/2025 11:28, Peter Maydell wrote:
> On Tue, 15 Jul 2025 at 05:42, Jason Wang <jasowang@redhat.com> wrote:
>>
>> From: Laurent Vivier <lvivier@redhat.com>
>>
>> This commit introduces support for passt as a new network backend.
>> passt is an unprivileged, user-mode networking solution that provides
>> connectivity for virtual machines by launching an external helper process.
>>
>> The implementation reuses the generic stream data handling logic. It
>> launches the passt binary using GSubprocess, passing it a file
>> descriptor from a socketpair() for communication. QEMU connects to
>> the other end of the socket pair to establish the network data stream.
>>
>> The PID of the passt daemon is tracked via a temporary file to
>> ensure it is terminated when QEMU exits.
> 
> Hi; Coverity points out some potential issues with this code:
> 
>> +static void net_passt_cleanup(NetClientState *nc)
>> +{
>> +    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
>> +
>> +    kill(s->pid, SIGTERM);
> 
> CID 1612369: we don't check the return value from kill().

Do we want to check it or "(void)kill()" is enough to fix this?

Thanks,
Laurent


