Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABA1CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3A31-0007Ls-4c; Mon, 29 Sep 2025 05:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3A2t-0007LN-7n
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3A2f-0000kg-Rx
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759137567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7eP8mAm1Y8SjP8TFSezkxsP5xOi1NaEMqxoGNSZ/X2g=;
 b=M4Cw4ooPxK7LDjzJ+XQ71t2p/HV2OUUcqS72BVQSbr4flyCq3cJgTqEqBo9Rmyj/dMQ7Re
 G4j1ttpdkIb5i6O4McV8Z3ecnJUlKd6tVTkcub6CEsU7iE5ErwG6R8wv4KSapZw8KbY7Ua
 YP5NzWLdCijyUhyKmfbLPY7pP3dXVdQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-4jrxH1xyN-6wK5bgW55wGA-1; Mon, 29 Sep 2025 05:19:23 -0400
X-MC-Unique: 4jrxH1xyN-6wK5bgW55wGA-1
X-Mimecast-MFC-AGG-ID: 4jrxH1xyN-6wK5bgW55wGA_1759137562
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3826ab5449so425212266b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 02:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759137562; x=1759742362;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7eP8mAm1Y8SjP8TFSezkxsP5xOi1NaEMqxoGNSZ/X2g=;
 b=NggX7slh+hjBLd1K7B+gEoyHtzMUkhh72rUdD4lrl0P5DRGct9uMedPPwUVIxkvmiU
 TQB7vBYyzwEXwsW26tqRyEeT2prR0d/ROpnlJPqvIohyk1gw9czmVC/N7W7mvlvXCWFY
 QSQ6XfMfmVgXBxTHN8PVr7nZXnuTAveoAqo9FXxzgFO6gc4sts+fm57eX34BPTwKWLPA
 cqlRRRmIwTphHVOlG54pt82jNMT4H40n5raB+KSkfa59Uqzg+T8UFbS//JPLxnOK2fB3
 PRgHBvCCCTlleWvpc6Fp6HFfqiVjv/NNiBjYoZ8pXQxSb3ixEFR37J2GzTRYZ3vnH2kC
 qlSQ==
X-Gm-Message-State: AOJu0YzdTzcqaH7jSmkdFaH64y1whiwx3/vcwMlDCIc6XB1/Fm2TWBju
 W3Ij6rO6T7tyrme6M8L717coxReGN4+xFHVtHx1G82Hxgh9ihOO/uZY/nskbJThZVAidY4Cy3mn
 5ZdPzXcliRoG5dw745gjb0FoQXmD28qwfk/2viUSCJuPpgByuHn+FRqAp
X-Gm-Gg: ASbGncvg/FsKsp56i2KKx6BWz2HHD8xqdi7EB2iHiv+vBrtEAtuZ57CSyuF+DauayFD
 Cvro8h+Qm10OoJHC/B23bggP7iPCWCIB1ugxntl5vp2BTSwmn/5hUKFmHFe2GjW9pFL2xduwGnG
 596wA07U6PYGE+gMl13D5NkybzuOBya/oM39o3EudDsU7pEJAnQkQJlIGGvaIFHcg7NOg9P9noz
 D/LOXoMcyMTF+0qO6CEr/tP42Jr4JamusSd2vw5ggimGFjz/w+cy0WQTKf43whQBUEcViiy+BxD
 imqzL6wqAY94MMVT6cSUt9/iLFkjPAze7/XHGDU4kWW7g+qZpmNUf6gCeve0fsV1qtLU7O5ZVpf
 FZbMerEMorNADmuatelz8O+Eig5HTTzBXYiFK99ejjXxZhw==
X-Received: by 2002:a17:907:d18:b0:b3d:88a0:ba93 with SMTP id
 a640c23a62f3a-b3d88a0c667mr483936066b.37.1759137562425; 
 Mon, 29 Sep 2025 02:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrP7VJO316n1YG0y/o5e+8dXOCN68zi+M7sMd27Csa+wSYKKZOmRSH9zdKe2yu2l91zHGaYg==
X-Received: by 2002:a17:907:d18:b0:b3d:88a0:ba93 with SMTP id
 a640c23a62f3a-b3d88a0c667mr483932666b.37.1759137562030; 
 Mon, 29 Sep 2025 02:19:22 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b353e5cfa56sm876874666b.20.2025.09.29.02.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 02:19:21 -0700 (PDT)
Message-ID: <2eec6166-f426-41f8-bb79-18ac7d5497cd@redhat.com>
Date: Mon, 29 Sep 2025 11:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition
 to DCO
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-4-pbonzini@redhat.com> <aNo7RaEOKJ5GFjNQ@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNo7RaEOKJ5GFjNQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 09:54, Kevin Wolf wrote:
> Am 22.09.2025 um 17:48 hat Paolo Bonzini geschrieben:
>> Using phrasing from https://openinfra.org/legal/ai-policy (with just
>> "commit" replaced by "submission", because we do not submit changes
>> as commits but rather emails), clarify that the contributor remains
>> responsible for its copyright or license status.
> 
> I feel here the commit message is clearer than...
>
>> +Exceptions do not remove the need for authors to comply with all other
>> +requirements for contribution.  In particular, the "Signed-off-by"
>> +label in a patch submissions is a statement that the author takes
>> +responsibility for the entire contents of the patch, including any parts
>> +that were generated or assisted by AI tools or other tools.
> 
> ...the actually committed text. We should probably mention "copyright or
> license status" explicitly here in some way instead of just a more
> generic "responsibility for the entire contents" without referring to
> copyright.

It's mentioned earlier, since the responsibility is not limited to 
exceptions: "To satisfy the DCO, the patch contributor has to fully 
understand the copyright and license status of content they are 
contributing to QEMU".  I find this sentence to be already a bit heavy, 
and would prefer not to make it longer.

Paolo

> Maybe something like "...responsibility for the entire contents of the
> patch and in particular its copyright or license status, ..."


