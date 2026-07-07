Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341D3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz7x-0002hj-Oz; Tue, 07 Jul 2026 02:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz7s-0002g3-RW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:17:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz7r-00016t-8P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:17:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667495K52526330
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 koqYcwSynICtwnfLhNN7j1CfIiBEnITuaoQ2kqMWfow=; b=JrRxHSXdwJWQbrH9
 pm7CC41bm5LFRL6WRCKqCDeQHs1wCvaD8MLvsd4bjRGlJr7ZwONwpPigWXddHxLD
 maJGoBNOqXbVscvIl+LVzybbGbKwFMoHwk/5nAxDcoqHzbEHOd9+nKdXnUWECBpt
 HU5o+cbg4B68phvCQkmu5XvCctqJkDXxWIyFLxYu1qUI++nS9a0hoxwOPur2ZUQG
 eWcrGrGWk5WidyZQCnqvg+E15Sd31HNtwLYLxyZw38GCPFHTC4hCW4kn1EMpa6T5
 OfwA8F4WfIvr/LLTUF6jnAb6LbhzaWlu5koAwVl3A1KbEVkP5Twk6g2Ozi3eJoHx
 S6F7MA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98mawt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:17:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c07f25de2so26061481cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405065; x=1784009865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=koqYcwSynICtwnfLhNN7j1CfIiBEnITuaoQ2kqMWfow=;
 b=Xa6wgTReW6u3HgkdxEF/rv3uUiOVSFq5gkqliE50q+pQ+p9+6ygnliL7PYDhn1mXmN
 O79BkyGFjF8fc94o2srbjx6X3iMOfAPxe0DUJMpSFe3LUL7tb3kfTW63Re3XJMALrOxO
 OdRASaEs/F3EAqnk0xkxeiBAGJUPDIcgOuUMd3CyNee4VJNxviD8xxN3rFbWuDgQbQWG
 o/r1jIscSOCXCIaFogEh94D7DuCcBiW6P0OGKSgk4sy+qo4ICPagLXCS9gda+288+8+6
 /zDcUEl2R/u/vEaRFvt7D5dPMFpFsj0AN+E5CsPNSANHOPBfne6mcq28z1LYtK8JNIUr
 yW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405065; x=1784009865;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=koqYcwSynICtwnfLhNN7j1CfIiBEnITuaoQ2kqMWfow=;
 b=VeRKvWe5u1LyGlvB71F2uVbEHaA/Z41JZ6WvnCdvAW2EdLG/j/eXDy+F91d82JppR9
 R0KKqXsygYz2mMjx/R1XkuQ2n6KgYFn1dBuvF0L1wKL9OM3CcGN/zeJ6twsxF+NPq0dQ
 nrKRWK56vU+38z8aOeU3bC1V9g3H7lkVp3giOHGGtNGsE7JEmf6zYFcnEZbDJ+ExK0Cn
 LuqLs/PSmoE4+bnIW2xkD6v9zOUJMbXF5FKq4DySO7WXDNP3DO2HUmo3X6KUfixoi7wL
 Lshts8WtkCBO0i3J6nEbtOketrfFGtaqB/6G+98f01vqx5jE38h8vna8U+xusO5v93qd
 bP3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+1E9/Pji5fv7LKHQpU3OsI4rSYgJINsAqU37dlaXdH4eD6KeeFSnDPJRgv5eU+8iuvV0U9agTkmea@nongnu.org
X-Gm-Message-State: AOJu0YyvpzbQ/htzeg7r9E9gOTpXma15qRfJP8wlYaL2zEXgIjgJAM4q
 siOSvx3sF2QlbOAC1kl4VjR8yfjqFvPpBMdM9YztCn03KFHadGd/dCD0Bve30uftUKzg4IKoUea
 nPfNCXC7nWqk7YENBOu1xfTpYX7GdoXfAOAuJBjH+KSi55b0aidMlSLTzLQ==
X-Gm-Gg: AfdE7cmvzHzYVBxeVw0LSb5nP8KJOueJp2dbLuQPB7njbyKLJH67w+c5mY7bhGHuJ3/
 d7yKH7D0nCeQFcNqsqFnuTfb7dQDR3meaANUr1ynD0Bq0HYpFldunw6uORAhszC3uPeKO9vfmxk
 Nqso9OcdjLCwNVbFx3Sn8GviAcVJZaIUlDqh0oW36UX83g4VpdUOsgCKCBG8WzoU/0BitOK5eJq
 KLLdtDTTXYdR+JBTPvnUPtzjs/o6y6UXUxSy0YdkaK8vWLRDTFmIDmv9NjF0VN2ItZtNeW+AP1s
 IHvoL4/NoXW8+1o/9teQk057wwoxsI8PWX9A9he/joCVxZfkQNlC+jsCASjkgm1YpGjzoB0nbOo
 352InNolitsWBjlZXCw0Qrdwz25dm2Na5Tv+5zr4aRH1j2YWmf9vDsv4JU7CVrg==
X-Received: by 2002:a05:622a:4890:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-51c747780d6mr40568571cf.2.1783405064752; 
 Mon, 06 Jul 2026 23:17:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4890:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-51c747780d6mr40568441cf.2.1783405064412; 
 Mon, 06 Jul 2026 23:17:44 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm28429447f8f.30.2026.07.06.23.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:17:43 -0700 (PDT)
Message-ID: <44a773bb-ae38-426d-80f6-84cba0d32b56@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 76/91] tests/tcg/s390x/head64.S: declare _exit symbol
 after main
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-77-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-77-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c9a09 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX0NwCmR+Lnv35
 dRDs1pojY5CGlDVXb/pmXU1nRwijM2u4JyqxoPP3ZSkYGNxznk3+e+Z+wmO+5fMjuxBj/f6Y/90
 nu0Ccwszs68bjIgxO4ztY2WpMO/0r3pPxC6Xy/8H6p4ymTQXmXN2y766yp6+4pNBZ34YQ/8EECj
 Vv9mR0UiW6+6W0yO8OS+X0ICKo9LUFThe5s2v78iwRbZZLOz4OIBAc2xhrL39ajCzbOH/WeuEx4
 Vm5cNYbeBKl9eyM6/WrrA5vQcTgJSjyzh9WUUJHiu/rvC3WXz+urXg3PT0ic8SGeFK64d4tcLuw
 HLSFQsNkLDDzMamEf/lYyU+H9kufx91KsP6VldLY7VWzMJz6SsBuGOoNhJBHwCQewrotnV0IIOm
 Re5h4OiOhqkuM173/fgy8wo9lbZRZ0xEJJhoTcAyZwrnuH3NNTgHV3UvKskxS68n65IMEVOmadT
 s/AoRGR5ExNiBF5MZlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX7zEw75Zx4skI
 Z5uZfZW3eXZ80QK+naiVrP2Ga7gpH5T+IK1oj+wpUGxjVTfbIQm0UhRRqZPvrvwnZ0dgs2ISYLk
 BWQ5yV5Lpim6CR2f0wWn1pzq1bGsXx0=
X-Proofpoint-GUID: 1J27B9gqBkmTISOrDW8yLVZWD-Xniwip
X-Proofpoint-ORIG-GUID: 1J27B9gqBkmTISOrDW8yLVZWD-Xniwip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/7/26 00:33, Pierrick Bouvier wrote:
> tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
> compare state of registers before and after execution. Define it
> explicitly.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/s390x/head64.S | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

