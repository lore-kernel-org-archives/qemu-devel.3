Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D41C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNnu-0006JX-UA; Tue, 20 May 2025 10:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNno-0006J6-KR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNnk-0001Qd-Vx
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747750718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jGHAhhBrC7f9aRQof5HBzIVxY4UdnMG2/lFtIORImUc=;
 b=GQ5FwJFuXR0+6+QNgiyOUh2hfY15fR5PZ4MqCVOPyM9tAcVzZPiBeFCXYz7KbRL+v5JiQ3
 UGOb2T9CJbsy+jSNcpx1pY7P07jNfRNA1xrDcaXT1ne9yIZ5VdwuOokJdY/Km4R51P7pFj
 N6tPRi3Hp/84dNBhS/7ki0pCOPR/trA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-rzcHRk3gMkyUgHYCzEWdLA-1; Tue, 20 May 2025 10:18:37 -0400
X-MC-Unique: rzcHRk3gMkyUgHYCzEWdLA-1
X-Mimecast-MFC-AGG-ID: rzcHRk3gMkyUgHYCzEWdLA_1747750716
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso1053328f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747750716; x=1748355516;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGHAhhBrC7f9aRQof5HBzIVxY4UdnMG2/lFtIORImUc=;
 b=B4EVooIbd13EOOQo0Mhj7UX4PIe756QVIkN0Qww7A5M5mW5TX5Qv4xGXqMeerMyuUD
 u5WouiHi2/dVGb6HnnfihetOC3M9MeDDkN3CgTt8htUFIdIq95xRbuNCJtka/eBBKIOY
 7xoR9Zg2aJbSAzfWsyQd4CvoLL4qO8LDFMZsEi4lBqjDbZ3cZdu+Wlw8wFHK65n28sYZ
 Wq36D28Xf3i3knfRJpRlkI3Yo0yUjACVQGvUiOeyvqlFfNc2QQ+3Kk5XMcsaE5tV9sSd
 aC2zk25Vfwx4EWj1Ahfeb2soSahP5FuJAnnRKwNGfyh9z5czOaArtXPDgXx6IjYUBAI1
 ov4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFUkymxz3vnRZ48nAUTGEFxnLHAjk5U1ZSZYIvnXokerfDC7/DaZz2VGEaBm02nsjo/HpVfSB5JyGo@nongnu.org
X-Gm-Message-State: AOJu0YzbAMJCDJ7+ayyUJPTrSek30GDGBTChFByZFuT9oMh3XOwNpIaO
 pOmaxrrMVRQHBjb6yeDq/FzZTUZ6Ol5aOkHaxvkJbXPrAgPzm3jI02q5x1QOmqcVRMcP6/Tn1Ce
 qx5mDffik3I7MPlZyDn73QpXeVAgFqLw0Ig8fKLTbz7ExDZywyitg7MagtZSwMuDH
X-Gm-Gg: ASbGncs44pEbbehWdKg8k6+X27qwmlzoY5/MTV5HU8xh8Shg93dro18Ky3RsKmjFPBZ
 FyDRqqW3Sr6G/Sf51aCPXlFUKjGKz17BDwgBtJO0Ho5gesVVdM8BeU5HzQ5aJnj8Al322KDL4O8
 dqwVCmec7cpQjkSO1P9bYoyMpP9MVeqNMs/E8D902QcuAfCDJNTz71pvvvsKMia9b7//AVNeU18
 5Py8PT+0Y4oIkYFQc2aU0187GZA6upasjjRMXiL0aiE8W0IUV4Qi4mAW96jC5bWB4VWC7tsj/l5
 8HTsD+a0cZzZfQ==
X-Received: by 2002:a05:6000:2306:b0:3a3:6a3f:bc5d with SMTP id
 ffacd0b85a97d-3a36a3fbdfcmr9212129f8f.1.1747750715724; 
 Tue, 20 May 2025 07:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5cWg9+KIzvd8d5Lrvm0anjZZ9qrP2zqJovdjciZg7wGs+UHEyrv4Rkaxj/3yruNlGJIdLg==
X-Received: by 2002:a05:6000:2306:b0:3a3:6a3f:bc5d with SMTP id
 ffacd0b85a97d-3a36a3fbdfcmr9212087f8f.1.1747750715380; 
 Tue, 20 May 2025 07:18:35 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-447f7d975cfsm34266795e9.38.2025.05.20.07.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:18:34 -0700 (PDT)
Message-ID: <a85ea01f-af0b-47d7-9ce2-b1b00d34ff68@redhat.com>
Date: Tue, 20 May 2025 16:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/25] accel/mshv: Add basic interrupt injection
 support
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-12-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20250520113018.49569-12-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On 5/20/25 13:30, Magnus Kulke wrote:
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index c7ee4f0cc1..4c1e901835 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -40,6 +40,10 @@
>    */
>   #define MSHV_USE_IOEVENTFD 1
>   
> +#define MSHV_USE_KERNEL_GSI_IRQFD 1

Please make this code unconditional - same for MSHV_USE_IOEVENTFD.

Paolo


