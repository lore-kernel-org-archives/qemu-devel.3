Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63D4CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMgh-0007LP-Eh; Wed, 07 Oct 2026 04:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEHDg-0002VY-BR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:17:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEHDU-00074I-O2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:17:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6967Stnc3538334
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WwyuiDqs6Hk8eHOLD9VafN80z9H2A8OmmllrTOUbRO4=; b=BvU2eHRJuDG0x3Nh
 2jx+W8ibpaGsgT3rSHIu06wvTJljA1BwTiSDfemV5jRrtfjXBjz/paj9XFhMa1DC
 9ensXZIN4GQG87DpsJCW30n3TefqHl4w3dffYW98CLmnyy4gStLOOPFLEsHfqtd9
 uCNL+ovSSZTbSU9ij9M8OT9x8k9piFn3aqmY2xEqL0oDo8UsoyByZbyvpHnCzmwr
 xSa5ebL6JdxpV4SzKfuC+PgztwlKLDyUvOXSuyQHwtdJilOjs3GhIL6+FpiJ+U93
 ggh52RsWJmMjvwl0uH8BS4tk/U3oR2iCsFrq7WdF1ntzTiMkG4B77Uz9SbrbdmV/
 QbvUCQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4vmrrdcm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:28:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso403947185a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278890; x=1791883690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WwyuiDqs6Hk8eHOLD9VafN80z9H2A8OmmllrTOUbRO4=;
 b=hDDXmqtQhlKY3OHWJN+Y7kK7YGas6LdUZXPM9+8sC7eEIp7eUrM1j7MeTDpIlg+LJj
 YAD24JmNLohaIFO7MrCMwrLofp4+TkAQ3wa+IMqABWv7ickYqPJnYe0NpjzEwzlfx6X6
 jtUzMfmCr5Xb5VVQZfT0iEkhyw37TuS4bocG87NLksZ91LfXufH8IHdVgDJVrbpLuuy2
 w0hzGhK33SKp1csw2OqMmbBiThIV1PKrB5gEmomiQonRlhDabGz7Pf/J5kzBBM3iGuQo
 9EbDPW856yUQOQ6ATy0q9teUhpEvTSVGgX7iYvZDc59VtDzyj6pFBArsiMbxgFmStVwT
 9Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278890; x=1791883690;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WwyuiDqs6Hk8eHOLD9VafN80z9H2A8OmmllrTOUbRO4=;
 b=jYb/N1Y8tz/FXfBtQT6fCmLigc2B2JHZkm82f5qkvo53FsL2svnCYRMg3V/ZXjxbML
 GpVwrZReTk6W5LNGhVkHMdcRWaiiHKvHicfuBc+Bxc8dJ0OA4M6cP7AnSLkJjlD61zMi
 wa769DuyB7SpmUQJgE5WLPEdT6/BF5Y31amxzIM0eM+tqL4Vm1YkSMyO/t22l9/hp7FN
 S0iePF4SHOGG0Y2lxH4RUZCTCZQ0ur72VU2zPMJYQDOPl6uVtKTXuDkvufXuRYcTT5f6
 mE7eL4iEdqUt0ugOMhL56KAcIm+5S6nyBZ/xcvYgfRrUmCaGNSw89wPPOP5g+4uOIiup
 OkQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC5/dG00VDC6bJQn6RTQrGZ+8RsiCBg9jsQUaePjAIv0gYC9JepICP2m9czjoGfHVU9Z52Hf8w+Vbw@nongnu.org
X-Gm-Message-State: AFuF++lRsEyqMimda9zdTZKLGzrFOe+D38VFopRSop5EnBh+v902Y0wy
 iKc3k/jfobDRCtIyxnp2TQCV/aGYE0MyltFNU2d64J55n1Zzf9+/97xnlXm1SlQnj4bjyyezu8u
 mA7wGGmjvFZt4vg6Z1jfARDhjJDun0+7+XD214TyQLS243AHkgshwhxOvcA==
X-Gm-Gg: AYBFou3HopBeKY6WJ2IHflmMis2/cOJQ++5/BWdjMnxPPeoo+pzZywMtKFoFnAAaEfJ
 0vUdBKDG5eOyXSSjIXHiTEENCPpWxf8EywzTNuTGKWENp4qVGiDDuj+PCTC8RghQwOOaY106dOt
 LHCYtKISnevYb/rzlEaFk2RO0VxIRHqfLL188BygX/7AXFo36qLX+oc9489hK12ZF4o7phoV9cL
 aUz/EScXZ9MflqgVmM4MqYwQC0eNHTiAjcXSwpHhDF07D39D3TcgfyY6yifuAEiDM9NbicNWE6+
 +/RzcS57+w7amGA6FqxblpmaIYT+6UpnOF/f3BCBVznOOzU03UpGwdWIASd/mihA35vEBocyXyU
 GYyurj21KITgBjwbnnY3qRWbdfvJ74axBSg==
X-Received: by 2002:a05:620a:d93:b0:93e:787e:bd72 with SMTP id
 af79cd13be357-93e8610e5damr401695585a.35.1791278890178; 
 Tue, 06 Oct 2026 02:28:10 -0700 (PDT)
X-Received: by 2002:a05:620a:d93:b0:93e:787e:bd72 with SMTP id
 af79cd13be357-93e8610e5damr401692485a.35.1791278889689; 
 Tue, 06 Oct 2026 02:28:09 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c40a28sm62854195e9.7.2026.10.06.02.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:28:08 -0700 (PDT)
Message-ID: <21900cbc-b134-4b1e-bedf-3485c50b988a@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/31] Kconfig: Extract config FSL_IMX{6, 7}_SRC from
 config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-23-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-23-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XZ4cX455 c=1 sm=1 tr=0 ts=6ac4bf2b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0skcEKqPhHGgDZmAeYYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: J5X6eEzRzvCcbAawGBDbVyaIwgcmzk4a
X-Proofpoint-ORIG-GUID: J5X6eEzRzvCcbAawGBDbVyaIwgcmzk4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX2MOpnnhg1mqC
 1IqE7PC0HIxEN9qJf9LAMqCGWdz0AKyMrLherXyJi8u//79IqopAgP+DYL32c2JkEdZmHAdMvK9
 nvDuuql7bYqYPtNgAIX8AnkwQZB/IUbVmLTDU7pR+Vl86IbKn2PqI94+GKh+7ujjhMk7W03HSd0
 uk0y7RBnDmcQqNvNccOEWi7mn1zV5BS6i1huyZTB/AJfNpdbRk+AmG/4Rc3aLUjN5lqjD0vPxXe
 msvpMwoN8rgSnZKrUyozf6WFnc+fek+MGx2+OHlsS86L5jwxGEVZIBnbC4k3gjvl/vv0QieFKRM
 ZpLGOEEWRtuNCt8+w0IzFYIh0BualCFk+/ZVHIWBNHP0u+APdqPqI4j/cLliSAsLDIfBRcLW/Dc
 fHr09EEW55wig4mfidsaMZFsTBy1V1QCMWcJUMCppdt7PySAuKLD2WNos/EcrHJXfwZkvYbzuj1
 JWpruTJ8KAYEdyQGE4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfXzVRqKL/7tE1e
 hY8rj0woL96b2Ew+TN4yxyI6pubacGzxQkLPIGWHAl6NHXCG/PCkXi4pDKe3DDj5CAWaqoOHB5q
 u56f0Xoyucfa90xd/egMzGyB0kmxrzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> SoC-specific config FSL_IMX{6,7}_SRC to eventually eliminate config
> IMX.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 3 +++
>   hw/misc/Kconfig     | 6 ++++++
>   hw/misc/meson.build | 4 ++--
>   3 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

