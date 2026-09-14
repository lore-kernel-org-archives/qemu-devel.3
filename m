Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790EAC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5yy7-0004gh-8C; Mon, 14 Sep 2026 01:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5yy4-0004gM-Dh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:11:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5yy2-0007Rl-Ny
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:11:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2ePAV403530
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UX4LYCGXXBDEOblF2QNLoUMBC0b7FDyOTu9yY9joyxQ=; b=fX2+e6NCNWGa8Xkb
 vbIDlGS53hnWdEGyLebhg1cmztmqcN2Ah+7QrNxzw6fEJLqKYzSp6bJUCD2mE5YC
 fYuAsO1Qzk7YE/4zRy4tqR1JaZfdnJhPnOsfuVndqUCdAkhtaABr22fjybKovBtn
 ycyJqqfH925Sc9XNW3M+9fFlOF74SvRM2s5DfDWooDGaI+jB2kvy4bPoCASdmrND
 UqXq5C8NniHpsYjSzp36Lye4SMe2m11MJTFhQ23KIVHyYXlwtK9eL4dh3nNulJ/h
 yKN+G+IrcpgSym2pOg5JHLZBp+zqOuBZBk4n3AaNFgwEpDYwNT1iJZM6SSd9NU0Q
 hIMQag==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cn3cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:10:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-869b8d63e28so3655133b3a.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789362656; x=1789967456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UX4LYCGXXBDEOblF2QNLoUMBC0b7FDyOTu9yY9joyxQ=;
 b=AzXERh+zQVyQb+NYhGYOqEYSRsiVwDV86TbijybE1dmcPmxXGfRDor7FmK9OBe5Em5
 /4gH5k00w5gJmQI9EFGaWR6Sf8P3GXnLf0Ts0aVpP6ZIFSkJsTS0+Qv8aNeuH1T19PxZ
 sI2hlRsA9V06uet8AuCkdV9hsAEsR7bwTT6I8zf7NuWGy0Aqm9w0AKQor44lNTGBdRrM
 jgNmEVrNXKTloWpDSwKOP0wDiIRyO3Q9BU9azR8L/RHs4BRKdDZUVT5WFzcB7PVBojdc
 8ayOWLxIMbSvA9IvIYLbA3Zp/d6OYa20WQWQzsUy69rgEL+WHM9oTd4gfYE2P4p9gdzh
 gYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789362656; x=1789967456;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UX4LYCGXXBDEOblF2QNLoUMBC0b7FDyOTu9yY9joyxQ=;
 b=T+Ep75ibPZrB7f8GTABtcv8yy533tRgUWeOjdxO8CDm6y7o/oCM2cmNlcQws5MpNfK
 /77w8+R4NFWdELSVI8bq8ssHsHfdQ4+JPP80tx+HFflqNaCTHsKpcgHzIgWuMIRlNWHw
 A7BPZrbUVRZhQmnnTBpCHOcmrsdJWoA9hNLbOjkyT0a0jZDGmTsvx8UhJJ/SB9PCj/jb
 iu4y9ISbPz8ABsmx3/64KqG0t4O2wlXKZgYjHmffK/fKqibli9OjKhp0p70M1H2InFST
 wg+h4p/HyahqQsM6qivOqpJK3HQ9nfPMvHd2WU242v8OmgTr7yXZQfKPqTNroSQ2M8K9
 UD2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByjvVihPsGH6Ck8sBIFR+QG6ZzrzItZwKlqJy8H93856PodUjDa+TpmvfFSQCGOIwT0jABGsLLpVlnO@nongnu.org
X-Gm-Message-State: AFuF++mlTnqCenTPRLzcTNW3w0PO3AEHtREU1k7+H5pKmvNsK7lvrraX
 GVnEYz4P6z1qRIF4GU59DAi/enDIQS3JW90aTrGAq16LLys/rrtiBs+xAYxAi2INVQlZKGYFxkZ
 lE4m6eLMjRp0LuApvdO68omWI308DkN2NsDClpOdADUjSxlTPdyWByaTthQ==
X-Gm-Gg: AYBFou0CeGoqvEGeuhUszDwiHQv+hzU6VfHiEgX6eNPYmYhVG5X0Pokd3Cze/dCSVjl
 4iH7fcQQ4wNZwJXdytexyGpMgszOsgifKnAykDxsg6TJlR0+K1e0MP9cWAUMCzfTYGESU+qSe39
 GEe7HZmDDPirtTRcOFwnCbg76TWlrafAy+C3iGf1mZQFCAw6a3EQXrWYAitZbBhQpSvezHinnOD
 6/PdQTzjKAX7iYE4bH7gra7T3Wwc+dJScJSqE4p+BF1wjlUFUH0kS3OefYuLjMLaa3L2iY8118P
 QYcf3FjCMi+ehyhn/p+Q/CaX/Jf6+J6p9ux108aBmzbNFz76jkFlJzd/i+ikzFzILJiF/+V57ST
 fGOrVjYDWH/T2oCTzS53/EB4jZC1LQn3wcdp30JtL1gJhhnX35/D7caQ=
X-Received: by 2002:a05:6a00:148a:b0:86b:472a:e84e with SMTP id
 d2e1a72fcca58-86f857f02c9mr2131178b3a.20.1789362655965; 
 Sun, 13 Sep 2026 22:10:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:148a:b0:86b:472a:e84e with SMTP id
 d2e1a72fcca58-86f857f02c9mr2131143b3a.20.1789362655571; 
 Sun, 13 Sep 2026 22:10:55 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b287c06d9sm3989402b3a.15.2026.09.13.22.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:10:54 -0700 (PDT)
Message-ID: <b232415d-ac0a-43a3-be24-0e5ad6184aad@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:10:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] tests/tcg: prefix meson built docker tags with qemu/
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3MCBTYWx0ZWRfX4hoWdgBewnrc
 wYXWrLJBjAAo9U5GqhXcTfjF09wY7AnNYCSYb2v7oBFIg3aIOdMUdTISW0RY0OjAJGQhHT2SMIJ
 Nn5UWFbDx2gR3FEy9JgUQfCcJ4GoYvAypq4Is4TiCRS0ahES1NzAQ6QF+s2PISAtfc16QbPXuQe
 ptWdcgiJM4T78B2bAp1XSBeEnDlKBW/45UgkOh2QnDmALbXcCDW5NSkXBZrqOXYA53lWTk9ErdO
 RZsrvbyUJh+g6bPEJ4+jKZcS050sDTsxRejIwMBHtV94Ssf4bRk1ce2DcXz3NR34vf5oyvWspuH
 LoVow8+rvlMgikLZmlVFBejOAfFQgMkS9TdCvRoGaEIHGrGWdUhdnaxbSXhh1Npb4r59YYeqIK5
 lYWXn0qObnhf0vsJt0uuHV7Gb8XA0I6FcSMq7m6CSmqjOV+RuybrOTYNL+2LO5PlldmLoyAoSEB
 G6BekgFjNmTGiKKiJuw==
X-Authority-Analysis: v=2.4 cv=EMyTQFZC c=1 sm=1 tr=0 ts=6aa781e0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9om_HFOkNinMv-LYcsYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3MCBTYWx0ZWRfX2OSIc80gEam2
 yMH50sRdDiPLSCQq+RsphXhiN2OWCeHZpojLZA3PrCUQ/dEtNeJU/XkJ9I/WE3nae3y06Zwa52H
 Qi6fW6EvxHZ5t3hBbfw2YexqbUPuSpk=
X-Proofpoint-GUID: dNpi9I0enDDSOhxYg6KTOQpRGW_PBKGU
X-Proofpoint-ORIG-GUID: dNpi9I0enDDSOhxYg6KTOQpRGW_PBKGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/10/26 11:14 AM, Alex Bennée wrote:
> With the meson changes we now build the images directly by calling
> docker.py. However the Makefile.include builds prefix all the images
> with qemu/:
> 
>    # General rule for building docker images.
>    docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>              $(call quiet-command,			\
>                    DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
>                    $(if $(DOCKER_V),,--quiet)		\
>                    $(if $(NOCACHE),--no-cache,		\
>                            $(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
>                    --build-arg BUILDKIT_INLINE_CACHE=1 	\
>                    $(if $(NOUSER),,			\
>                            --build-arg USER=$(USER)	\
>                            --build-arg UID=$(UID))		\
>                    -t qemu/$* - < $< $(if $(DOCKER_V),,> /dev/null),\
>                    "BUILD", $*)
> 
> So to ensure we don't end up building every container twice make sure
> the naming conventions line up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

