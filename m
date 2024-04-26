Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7FDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PcZ-0006uR-W8; Fri, 26 Apr 2024 13:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s0PcX-0006tY-TJ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s0PcW-000859-2z
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714153462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OLyfiPNXW5RpDmFkkKW0h9B+FkWF3BOHeWevB80hqwY=;
 b=KQNuKGdPeDRIxvDfXxiT3k7i2gOCAdbQ0ZHpOllhSH0W98/aKpVWZ8tyieldDjfCTu+hBl
 ZxkRM+vBKyPImJGDU3ImJiyr7uqGY3tMmYVjuX9Yg6PGl649FqBHJtP0nkuTbG+fMymDrU
 GojYfc2jDeDRE+gn0d96Dz4ZfKg3cNk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-VBxK2CCMMqqYwnXfE8QWlg-1; Fri, 26 Apr 2024 13:44:18 -0400
X-MC-Unique: VBxK2CCMMqqYwnXfE8QWlg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2decc7026a9so21396621fa.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 10:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714153456; x=1714758256;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLyfiPNXW5RpDmFkkKW0h9B+FkWF3BOHeWevB80hqwY=;
 b=r51Lb3p+QNieBU7a1wx5HIVlPJnPab585cNGOk7CKIVJ4XxTHZle34RiFZxfVGb9Ca
 VIfNPxGZViKlYAV5/HggDJTGqwe9gm40aFfhGllZMnk6bPoW09El9LBQPX3PfQLBL6dP
 oyF5OqCpi670B5KC0xsEmU25KXPdhOrAwgN27ydqChPMRYeaj60/Pxc8zJo1HNIq32Zc
 D4Don4hVHVmMi7v4SaRypcwLzeUk8G1SoHBZ56X4ZKPXgqOYvjWVx7WH4c2wBganaVJR
 4P7sFWraXnviWb1Sb2Q9BC2vfjvuag79jzZDTJ51uN1JfEDfJx+meAbGrQFKmlKs1U5C
 UMKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8xonAMg24/XdoEcwFcYQbBxwLmsHWU/xb4A02TiYTIYpLoXVTBWtaMG4jAn3fygpsjfRNIqFlDsjSGRGexg6IDAuyV/g=
X-Gm-Message-State: AOJu0Yxea8TICV3QsidRpqLMBm4WTewA3Nzr6yepapxiMmQd+5+5af5R
 gw6gZhYZg9R/HBtrEFwcmiSUuawCELv9WPCAe8FVDYdTwIm5rRXGcAdQRDz5BKsz85QTisuh7Jk
 d2sWBEikH16sL7qiHDwCxfHQdZZFChC2I/Db4F1HjTB3xSQWwgsQv
X-Received: by 2002:a2e:9801:0:b0:2dc:d2c5:ee9 with SMTP id
 a1-20020a2e9801000000b002dcd2c50ee9mr1859569ljj.2.1714153456763; 
 Fri, 26 Apr 2024 10:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWCCxs2Ww05Hdi0D/fJVNPcmggJOpzhKc3v5fvH7ABEhERC35u1tVSydlA15awf6x/HG7Kg==
X-Received: by 2002:a2e:9801:0:b0:2dc:d2c5:ee9 with SMTP id
 a1-20020a2e9801000000b002dcd2c50ee9mr1859556ljj.2.1714153456376; 
 Fri, 26 Apr 2024 10:44:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82?
 (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de.
 [2003:cb:c726:6100:20f2:6848:5b74:ca82])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05600c384900b0041b0c3879c3sm9703343wmr.26.2024.04.26.10.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 10:44:15 -0700 (PDT)
Message-ID: <60cd9494-fe97-4134-a16b-026e14186eed@redhat.com>
Date: Fri, 26 Apr 2024 19:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240424215633.48906-1-walling@linux.ibm.com>
 <20240424215633.48906-2-walling@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240424215633.48906-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

On 24.04.24 23:56, Collin Walling wrote:
> Retain a list of deprecated features disjoint from any particular
> CPU model. A query-cpu-model-expansion reply will now provide a list of
> properties (i.e. features) that are flagged as deprecated. Example:
> 
>      {
>        "return": {
>          "model": {
>            "name": "z14.2-base",
>            "deprecated-props": [
>              "bpb",
>              "csske"
>            ],
>            "props": {
>              "pfmfi": false,
>              "exrl": true,
>              ...a lot more props...
>              "skey": false,
>              "vxpdeh2": false
>            }
>          }
>        }
>      }
> 
> It is recommended that s390 guests operate with these features
> explicitly disabled to ensure compatability with future hardware.

Likely you should only report features that are applicable to a model. 
that is, if it's part of the full_feat.

Otherwise, the caller might simply want do set all features to "false", 
and we'd fail setting a feature that is unknown to a specific CPU 
generation.

That is, you would AND the bitmap with the full_feat of the underlying 
CPU definition.

-- 
Cheers,

David / dhildenb


