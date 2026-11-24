Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7183606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YdvJDNZU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KcID1rko
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzzc-0000WV-Tb; Tue, 24 Nov 2026 18:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzzV-0000SI-M2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:32:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzzT-0002rD-WC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:32:01 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaa7c2830185
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=; b=YdvJDNZUyxhdhS6J
 arsYzy3lKCqdBPApC8vjWOmux1EIZ/i1OW6ayttqTLrpcttLnVewWbiIMUWRLJz0
 RmmzuEZZCfCRwALk8iiU5w1FrdEn80w8EaCCPuo1QryLIYZsv52MaPN7dB5/Fx6z
 l6jCl47R23yif+/qQfkM5FhT8f14UNd2fOQ2jupj4TKMNHZrqVPmmT6zOyrtzDL+
 5l4JKsIwHiZQIhO4ZAJ6D3jyEh4dbR9gTyjgAnpZqeLCk36mMOeNAxvWBa4P3WlY
 +e2yGHnhMeCh/SpVzWeo/Iwoh3bYrLMJDCh6MNDsq527n5lkVfRmsYCXMJgLDRBL
 uQNQSA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxka0b2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:31:55 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b4bfc0b441so68552947b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795563115; x=1796167915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=;
 b=KcID1rkoY4pmQwxiKteVmSba5SeQDSGcN8V8/uQ+OQjMT1epFXB9UlsPAKtQabiRbS
 31yWoszppNUQY8nDVX3A/BqoMhkW++w42AQ8LJ6HfATT+m60livrR8yjg1WOcnuWoTVz
 vT6tqX8PIwsv9jBSr2qd8GR4B+RYJIHWks+H6fN23o1ezS9xl+qARBHD4gP2h2m79OMG
 v76CIPzAD6OJaIwdrEXE+ZjdCJdqvaqQdzXLmA2XcAJ9qVKxGxm2GxpUFYX+CJvsS+1l
 ulgPzrTkrmJ/Un3xjen7J8jfmlDIZ5se4l8+Y5auq5iEoQbJxKKA1X2rdS8L/SDqHlGa
 WODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795563115; x=1796167915;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G1ZAm7akP9D8mbltmYnzmqncqYxXc4x3mIjxdEr9bU4=;
 b=0dnRetAwAoIGvNnxHvlRdguAUXzuoK1Lk9kIhwtU36IFpCI979Hf9J2mtilmUnzy4s
 +S0k69O5hv6uSXjlmYBFIR67eAfKRNy6a8SLOSMipF5OM8k4rGNisvYtnJ7W60XxnTHy
 sTMuBVP+DmUkX1Pp36ico0+FsYF9Z+o9IOjeJfbzAHMwKtfNPKvz5O0czbSzlh1ZP79B
 ieFpxIIxZsvQBpJSD/qgu3ODV2sWEOGuWCx/xs048W82US8HTGkS1XRv3JFMOSJgS9It
 jt2xQ+I5ZQjBCU5YIUHKBePjUuuW8E4PZigx7hhfUSek2cZXADEUErzKb+7X/VKbMSZ5
 sIug==
X-Forwarded-Encrypted: i=1;
 AL+hErFttlBgrH1rsWXNu46qEt8uTtPDbIZ9kHaLd+IjHzue+fThlhTXg2cWJjVAZcT+BsEeF99sojwfj5Wt@nongnu.org
X-Gm-Message-State: APuU4Z8Koq15Jw4pxL92Jz/6h7+19qekYBm0MNO7jEPFeaz/02DW+YLu
 g5wA5c/tl1DhKIOv8Oi0xph6be9vtgj5pJH+pEXnIzcFIRL+wVvFBDkyo+IGEj4xmvQOfEJ3y47
 2bP93yLBCSs50ESMDuhynwqgCA07510ceTy231wGpAgt/OucVHKKkZtrqqQ==
X-Gm-Gg: AZFdTZd/rGvOTh0Gb+sZ1V7ur8t0EpyhsoXFdnM9crF64ODu/7xx544q+BePatXvjlx
 Rr97GPLE4E87jIIE2fUbTBLzYg5n635eDfm3W4DVcEvcamM4FV5doAkyvmaQlsyK/neBANQjqOY
 JXu/kD2PoVElWebU0rTP2WdO0X86r89BIsmDCURZB0rvdvLEBC1QYe3hEAuEuD/J8F1LJ4K/qK/
 fsMThrQkhbMzfYuKbJxhNlq7GCKHOr/buLbV+jO2bueKJIWM5LPkC3Gf+ibENW7V1M70p5phAqZ
 vBFbvoLQv41qe21Ol3t6Tna52eX017BTDEJlnC/Sh/bLqq2Cumfi3S/nn2ZjiJ/ql2XrUjdBbFp
 zhLho21cE17//f/4Shm/xBBNe4buJcgfULlbN7Dy5tIINmCVXQpXOH7ucxPvaXeYlTddJVvEhK1
 eS6EolYm4=
X-Received: by 2002:a05:690c:e3d2:b0:873:5c0f:27c with SMTP id
 00721157ae682-8b5204ad248mr71151047b3.38.1795563114715; 
 Tue, 24 Nov 2026 15:31:54 -0800 (PST)
X-Received: by 2002:a05:690c:e3d2:b0:873:5c0f:27c with SMTP id
 00721157ae682-8b5204ad248mr71150797b3.38.1795563114026; 
 Tue, 24 Nov 2026 15:31:54 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm29788684f8f.36.2026.11.24.15.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 15:31:53 -0800 (PST)
Message-ID: <2f326926-16e7-478d-bc57-86052033199b@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 00:31:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/21] i386/xen: Don't inject event on invalid port in
 qmp_xen_event_inject()
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-10-dwmw2@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-10-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX5obnvLo/4aVl
 x0Xni+quh7ldLoy/kSqRHK3aDNDxcPn+TQKW1uF3+FO7b0pp2wP6CM12Y6xX0yZTjPPH9RHcjrF
 ryCNM9txnx5jsuQbov/RLcDdxBCCEULab0ea+c4AAnxAQw8eazGXmVYYKAcJ+3ABufFHLaNReQO
 YDNaOSRC0fs2RCYUGY8M84TImXKAVxZc4MPoVDmyoqIreEMHAPdpnftn4L+/Bj9Tz11KuCB1FuS
 dXUPp7QFb8RjeUt8vkxYbfQQAdGoa6ei9Pe4pRIT23x5SEUx3yDVYJiqrASad0EY2HXTnHiwaz5
 9871yN4byu8hSFpdkHwx0F87Nz1wNSkWEJuui/rzqfRFAPAyTVErw94+IjDyLlmNe+fpvlK4dsd
 PfWc63eqFD5ZAS/+H7HLNu72+ydmLF/cqT7vTtvR5TWh+DhQiE3wqzdg/fMzbINYLq3X3OjWJgP
 egaNrZoF/OO9KIqptWA==
X-Proofpoint-GUID: nZxzPATZCNSt05i38i3XZZyABQfm0mDF
X-Proofpoint-ORIG-GUID: nZxzPATZCNSt05i38i3XZZyABQfm0mDF
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b061e6b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=pBOR-ozoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXyJvf9YnEffh/
 f/7vFPbM/ILj3x/tVlz43b0YiIo10T0sT0MMHRuzfQCqdL2iNdxGv3EvFwyqOLok5eRmu3he+Tj
 sAPc4cS8Ubl4hEtL4ZnuAaUVSOXak+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 00:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> qmp_xen_event_inject() reported the invalid port with error_setg() but
> then carried on regardless, passing it to set_port_pending(). Return
> after setting the error.
> 
> Fixes: 507cb64d6e66 ("i386/xen: add monitor commands to test event injection")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

