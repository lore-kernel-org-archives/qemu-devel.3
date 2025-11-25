Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA8ECFD37F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqGv-0002Kc-EW; Tue, 25 Nov 2025 05:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqGj-0002Hm-Ij
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:27:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqGf-0005fj-Pw
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:27:33 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso4042681f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066447; x=1764671247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dsNRN3M7tLf1Kcxi1KCFkpYYf2qs5k6tXujcFgV5vT8=;
 b=VhVpS+Vjeua5YDq5qoiovuetY5pFdQo49cXqpVLWM4d4M9RPFcIv53I3CF0j+nmFmZ
 Bu9wdLKuyMip8ghgU5CYVVItaZbiPJPyFKZS/z/QobZvNomFxm4154S46Z1qXmrSOc0C
 atVVLL/P+VPR3mJSR9bPd+W1/zs20hFWmZfazLV68jO4eftEyHFHjM3CRYVpNv8bH9eU
 6Osi9eECvzhszVtSnN7kRL5iOL5Cir+7dP+4D695C2Xsh+2j/kw+wNmL8LQhCD1LNnLV
 z8diHNt3raH8k+XHaSrdSIOd/gAl7iMaGFhWQXlSh16IthKPU+025pmJ19qEaVjgFdky
 Tx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066447; x=1764671247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsNRN3M7tLf1Kcxi1KCFkpYYf2qs5k6tXujcFgV5vT8=;
 b=fq4Ht5tX8jmhqdV0aNotqvIXCDx//Q1S7iVqMXdtFOX32dgPpnkYeOfeWDH8J58Ihs
 IJ/orBOqAX2mGjJY0ssm5zrlKWSgyyGB9dVlY6168xrsRUs3VWkBRVnpOshZzGIdpuMU
 VzebXuGjZCb+WVjShS4Vfp5VKK/nUWgQGCNswgEzjsKGvjozH+wrUc3rapXZYGKZl3qK
 lQK6aRGvhyl5igt6Dd+wMM5Ret7lGPD5diJmT2QBW637qwLyYB0Oc+9kYGWh9/vNdRYF
 BqIZKh7HMbzJRHtttlPM4SHqxv+dM9ULmMhYV+6Vif5yQTnBXcIbCD8/OQlzPCPIHpuv
 gXTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/KD1DfnsxQWRHTKRPH33l43R0TDK2gxzt9cUGBuqVFt+4TgHcUSp36RdKryf7Ntcxcffu28buIJ/j@nongnu.org
X-Gm-Message-State: AOJu0YzmQK7xDjChKNG58hBEIruVBQMwSY8wYck63SloaoxUWLPz1PV9
 jeNlAg7axis+p/4HGD174vfWM6B6COUuBf+tWtts/MP5AWcQqN9q3pTnDisRZcb+xDk=
X-Gm-Gg: ASbGncvzfk70yoWfObWYie/JZv6obHseyTA847/xqbO2XJawhuSeLPcua+1C3TUU6QL
 ADQscAEmNtKVu5rOktccNw6IVeM5h68cLBnhjHEz4WJnrsmI7XMWR2B0kmbHMAfEYFbRFUAauyz
 YrJ/CXCsOquzqAkn03AfzntrVkeXRRZljuRmTSHtMpy96FhjRUW4r+7MwzMLkoLzhQxz6eFW1VI
 fyN9WaKStJ9QyH9a/S0qUxhjHTr7g3SFEhVwd1rDGQ1q9eAe44DcxeW+jkzRtEPERm7vJfUcfC3
 uDkVXg4azdBBaBTNrlQRyc3R53meITO/UXBzo/I3m1EiSIOdIEg10WFWSj64hQRD47L8YQ6MnLY
 oTrZk7zafX8MUydEcElKuCkXWTvn6QjN+Pqq4e2kZodLY6K4Eee22sxaPXJeze82UEQorqn2q3+
 fay/EKNPJHgfP69psjYOgCim8fbB5yB36XFUxdzUDr+WPgIuBUr4YdJA==
X-Google-Smtp-Source: AGHT+IHKKU4ceMuaE95csztZcp8xaXOFHTU3Bea9HWqGWegeju5+IOQNhIe6zGPw+m52NYEXgQy3dg==
X-Received: by 2002:a05:6000:2dc3:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42e0f35913amr2072165f8f.52.1764066447520; 
 Tue, 25 Nov 2025 02:27:27 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a81sm34239083f8f.26.2025.11.25.02.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:27:26 -0800 (PST)
Message-ID: <f34353af-ebe5-4a43-9982-385b4113c983@linaro.org>
Date: Tue, 25 Nov 2025 11:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] ui: Convert to qemu_create() for simplicity and
 consistency
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/11/25 13:14, Markus Armbruster wrote:
> The error message changes from
> 
>      failed to open file 'FILENAME': REASON
> 
> to
> 
>      Could not create 'FILENAME': REASON
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   ui/ui-qmp-cmds.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


