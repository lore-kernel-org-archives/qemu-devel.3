Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7E606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nLMnagva;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HIJcTmYX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbbK-0003C7-8I; Thu, 26 Nov 2026 10:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWbbI-0003An-G5
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:41:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWbbG-0001xW-TS
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:41:32 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEW95L1022842
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IQ85ilLmMN0r86RviriAxcHemBHLrPTeGe2iVuPQyMM=; b=nLMnagvaDP2JCvyb
 Lp+OH7tBzAs+gg94hVQ8OQJQJx1k+5fdcmoeyiJXP4hWTmrIHX+cP3qtj/c0w5gB
 J8gnUhI5Qn6YncKXacF5DDcxAFrE2d03+ekl/vuzn5RH1TSUCp3XQu+GAKvIkvFg
 gi7B4zdBaT9HXPqBL4QHIqz8CwkVvQyxbIpfCgPVntXbsV9zUQ6X906CCpO0dcu1
 W4uvUiFZC8gSWZhgHLrAaUba9DYr2UKZjPUGUWkPFIv0aUjsS//Kp/k9xoYX7Qxl
 Mio5QlafUKlbTsZOHGZMAzRUMSwxaiGUvdNGNzsK95URE6/lNz5/cZIBkM2ps8oh
 LcrVBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne1n9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:41:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55b9c13273dso121002861cf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795707689; x=1796312489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IQ85ilLmMN0r86RviriAxcHemBHLrPTeGe2iVuPQyMM=;
 b=HIJcTmYXdh38ETnv/mJkaCbaTKHUHfmEl5ph4b1bCs4JnjelcgbHpbg5daTl9/EMjb
 VtwgJvnMvts0WLPpMTNXHsi7OZVuL2De8kBVKXkI5LDyPTL8RXBpoLhgM3WxM4T9WRMH
 Dkb3VZ+whFKWV8/93oGuw0yQK0fgz8C811ep4bsdCBfeJ15y8fHVqNI0mrsIcaXpqx44
 WNMbjZRMeBJh56aYRij3PUm3lOkEdzclnVGshQJ6E2pBhzFtjSsLQmdiXNcPMp35qREH
 n9pYFRUxbIZah4hZVg6fvmya6onHAKfErEsu3TZVTdHYjATo9qgVylzZp8+TWQEaa8U9
 D9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795707689; x=1796312489;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQ85ilLmMN0r86RviriAxcHemBHLrPTeGe2iVuPQyMM=;
 b=16/HZpAPrpDoHw1p6EcwX5+t5cVe/AQIyhEV4XY4Y5AHrvweIsWalyCo1672ptB2v9
 QSc6pHr2KXrN0zGq54MaPlrOm9IYBmGck+W2es5lgmIMdMWrIAExnJ8JQddnigVA70v2
 VEEfLYHAL/NYkFjDoU6v4k+urw1bUwl/2dsz7rugw1Ajaw1rUgzpfuubBWh2g4jXIfeq
 xWq/pVo7/Fpju17ZsanX2axZbZcGAIGCi8+EmWLAYIH5hvWCaloF/RVe2+cYLBfO9Cu7
 mTcQulBtXLgvfPdFEZ6IBEaZCVFqvcMZb+l0PUwudogMtrnZE5YegzaRBWTlI+IwS/b2
 bpaw==
X-Forwarded-Encrypted: i=1;
 AL+hErEUzzBxftJQJ9OaTuJg24pal1i0E9jMVKiNBqbboZbLVxqJpKPozBzzlNcXkBuBuL7mZQrseGgI9ZG4@nongnu.org
X-Gm-Message-State: APuU4Z8nETO1QBpCC7P0hbFslI9sh+qoqtch+ff5buYWZkaaM/S7zkWm
 OK+gOJdPS65wZgLXM1Ze10DV8QSmax/4OddAm4JKU6ji644zAM3grKMq38DqgGSO4BHIsIWcQ7L
 //xdbdprv5OxVAOW1kyRUxVaYux3pAel6NukouV9HmZX/JBrThoeqVvzttQ==
X-Gm-Gg: AZFdTZdFsc541NosumITg/IXA0TMJq3FgqziSA8aucjrXokchAPAWyl9XuuFqFnSIU6
 7aoWOhSxmU3RxTVCk7RwJWURKQ2d1EMYjQa5Wle25H2ZoiYd6wMFA3NFzY+wlfxOFyjTzIvW+f8
 Q5BL24KjFax+ACMHDumcD2tC3XBNe7jN5MH0ut+AZqrPa9u8f3cIWa9A/aGo8o5Ageg6fmdM9Yp
 uQVG3h/m32t6TcPT9ZrVOVMjrQlAIrJ7oj6kF2GoqyObv1/g+CWe6qEaB6dqXOH39sgdhYXWalD
 4d3rxvSj1BbleEOO9Pk4U+SkUCgybIx1WF/LviaJIMK+Icb2K4L17RSBUPQZiT5eeCuAGwg5c9m
 OAVLzVea6+kzknsX68J/tvKlbfDLloYp8UGR66bbezocc3/8rK71gckFo3uv6LjECcrwV+56QEm
 ba7QWRlbA=
X-Received: by 2002:a05:620a:17a2:b0:947:a247:6afb with SMTP id
 af79cd13be357-949ba965b28mr3889348585a.13.1795707688634; 
 Thu, 26 Nov 2026 07:41:28 -0800 (PST)
X-Received: by 2002:a05:620a:17a2:b0:947:a247:6afb with SMTP id
 af79cd13be357-949ba965b28mr3889343785a.13.1795707688221; 
 Thu, 26 Nov 2026 07:41:28 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm957744665e9.14.2026.11.26.07.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 07:41:27 -0800 (PST)
Message-ID: <aba99506-a519-49dc-93e7-1e45c904349d@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:41:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] MAINTAINERS: update Daniel's entries to be consistent
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Chao Liu <chao.liu@processmission.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20261126143607.2374676-1-alex.bennee@linaro.org>
 <20261126143607.2374676-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261126143607.2374676-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b085329 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f45CAlVN0ESyyzyWPnoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX/vC7fPExwxBD
 rW3KF2AuZteM9/AOrMcvq1Lu72uz1Xi8mM4A0RwlfcrFX4++1yB7s9UVfd+ZbXMbcl5ARf9KCMa
 cycZHKuMjon9cSj0DG6CQXDVXmGeC0Xs9onRl0nTfAiUmN7Ex9TmLIbssosHMYrgmMzPv1tTEy/
 k72BTG1jDDi3ZmM60WKbAwQj4ANuJ+IHkTE9ZvYCPQHtJZhyuF465OySBGWo0oPhutltxUbZ83w
 BYt2EwtWV/1/GxwTj8RVu7K2q/XeFhvzFxAL/F/DmFCdWmIp0/DeqaLk4Ue3dfM/A5oRIAmJp9c
 XJde4e3M6g3I5PQ/2r4ITXiO69QgE30qFXNJEW4k0fy2035NJcpxqeuO6hpM/1B20nNvde/H0SZ
 bERCT/Hl7n3uU73YHZ3U37evaV1nFj+ga040R5qlElN5TZ+h7vCPD+aQV1siNM6CDgDfXQXof75
 TCCx6Wbu2DNESTL7QZg==
X-Proofpoint-GUID: _96kx99BI-NBoFRtG5NnAg3CF8RSiv7j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX1h4tl/CwYi8y
 Z1vbFLmhPG8ug51eQLHDPQTbIB/HpiBIRfyCVphsrMsyNura/+7WjD+q6fVVNPLp/sX28o2V6rX
 dztwn/ZuKceit6krhIpSBbaIq3RNcZM=
X-Proofpoint-ORIG-GUID: _96kx99BI-NBoFRtG5NnAg3CF8RSiv7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/11/26 15:36, Alex BennÃ©e wrote:
> When testing my get_maintainers.py I was shocked to see:
> 
>    ➜  ./scripts/get_maintainer.py --list-absent-maintainers-since "2 years ago"
>    Maintainer              Last Seen   Email(s)                        Subsystems
>    ------------------------------------------------------------------------------
>    ...
>    Daniel P. Berrange      2024-06-10  berrange@redhat.com             QOM, QDev, Seccomp, Cryptography, Buffers, I/O Channels, User authorization, Sockets, File monitor, Functional testing framework, Build system architecture, Meson, GIT submodules
> 
> Which is of course incorrect but tripped up by the fact we have been
> utf-8 clean for some time. There are some entries that are correct so
> fix up the rest in solidarity with my fellow utf-8 using hackers ;-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261120182200.789086-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

