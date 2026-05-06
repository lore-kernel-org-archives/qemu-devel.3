Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A42CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 16:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKerh-0005QG-ME; Wed, 06 May 2026 12:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wKerE-0005Nn-6r
 for qemu-devel@nongnu.org; Wed, 06 May 2026 12:12:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wKerB-0007st-S9
 for qemu-devel@nongnu.org; Wed, 06 May 2026 12:12:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646DcA9t529341
 for <qemu-devel@nongnu.org>; Wed, 6 May 2026 16:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dwCULgaVrGoNHJj9SrPtbn7wWcjwnzY04ceOyW6wCGw=; b=OjHR7m7w8l5ZiAqI
 8/NShAhVBT1Vsyc92mxTc6y/usjHNGJIQT4xeDHl0yyvzGbtrj8U5ystbS2DrSFP
 TWAB97mCbip2JA1y1YBM7fq5zGJBD9GKUNjrCbB7NnPGejb5gEazvWfbr0UCwSSQ
 MTkPOHuw+9gyrIwwlewmyIaDNXPCUGfjEDk6KS+6UoAx6PJg+w4LJClh3xAGJJ3Q
 pRN11n7yusFkYQN95kWfg4zlqb06plQgKOgmNicZkmNo40uT20lMLxAhzU8nPD9s
 4GUeGGKWofLWp24Df1PJz88c2/qNp3mhH5OO7ifW1zt2asYMQhCxN/+2beU4cmP1
 vYoNpw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e015xa4t9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 16:12:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dfe9c058eso4761777c88.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 09:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778083934; cv=none;
 d=google.com; s=arc-20240605;
 b=jcf9XojSZ6XcI+I2R3jyFd5m/Vm66y9/kXdLicrzmnZMJiufEDIstU1tp1QnsT0MfR
 bRsJVNmhZ2J/MqCFwEl6GtGsJeDE+S57HcGmaQiaRFWpv0XVwH9X4S1plJWc1fMM810G
 +9aKqfhjeesJUvZBbDB9z65uJn5N6PyM1KsfiE+JImmf/XXZgWJvCDiFAUv6fd7tsR1i
 mI9grAjy9+AwyhjmnEUnMWDNGCyaHm2HNDZbJdC0f8kNpLzECH9J20FV2gI+0wKVpbwg
 z5/CE7V0bgVPKvr7XvRhruI4WQPtgynhNdh+TvD5ExEXQuZc4gHn4Y1GAWQD6ljRjSOV
 LNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dwCULgaVrGoNHJj9SrPtbn7wWcjwnzY04ceOyW6wCGw=;
 fh=4xuUYnTTL9sbwkxNuqqs4O8EfQ82FzuSIc0VsQKD854=;
 b=Rd92TY6XatddrU+UvJC8oPkqe+mcoANtVl1Y6w5X/lZ+R7KGGLSbNg9tpQq6AQwrLN
 HpA8Rvww+4XgOkikrTFNkDCOdInet/RiaR2HZ+RSOhxUwu7DytfETe+g5UIZ5M9Zr/Vl
 4ov7UW9qO72BhUyjewXQ9XSJ352gyjJWm8HKYuyHw24dmwC9PeViRSY9bsYja+2AmiA5
 KVvCC/JmGn8p+5ghl/6+PEtlstzHbzOiWys/c8o7QGb8U+0luwOSKbQDbTHTZMHTo6UW
 XxlOKCiyV+IJmIJPigw5u7sHcM5dwakBCxmi+lxOtHUUI2/qGThw6XMWpdgD+OD6dDRJ
 bviQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778083934; x=1778688734; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwCULgaVrGoNHJj9SrPtbn7wWcjwnzY04ceOyW6wCGw=;
 b=J5lFgnb6FMLhX4q2sB/9ICgRh5Yi2jJsSqxYibHnt6Xggw/e0q/XyIAwLgRXiFT4vu
 Wgh604vl0cU8byA9OvGwZCPmFkVg58v/cvzYDp3CRBeGD5szmi+CXFF5mr3IxnRACA/2
 04wOAeEcqyC5aL90eutaxNwjRjBJW2KnfNgu71DUcvGQvkws8E59CoUQtHXI6KyXx4Gf
 TC4JuPx82zCdj73KwKNw2IeQsEH6YWTKM5EqGjY4toH/eajOr8ZA8c4Egw+y20DTQ792
 HWhUjQzT+xa35dbzKWb2v91JkEyxy422wm/o4WVJ1+k6FvLKh4h2c73c73oqkik0FqNN
 T6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083934; x=1778688734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dwCULgaVrGoNHJj9SrPtbn7wWcjwnzY04ceOyW6wCGw=;
 b=ZJpix8bqqu1CuUi20H76p4Orr2Xx4R+CaSGXsb8/57n62VVyiYWv2ctRj6AvxDYa1p
 qBy+epHipg1rPkSDNVhujPHVEmTXAbOO1bzY1MKw47Xz/50t3a2eRlN0f9Hgzf0BqlIC
 9NP1e2kZUqBbjFje6j1SXD/HdoliTclaq4bEcRaFvrt1a0qBynGUjbl6zZmaa3ooHlzk
 KTKybTH6tvqFuSrI9KBcVioDm1imjKgPGGU95zqkqG3MR+NCkQwcJ5NcTBi6AU3jqml7
 XNQtiZwBR/YpczMF7ZRLJj93rye043T6BeSJydOQhav3BFiOWGSXBy/aiAY50YwrV44T
 6guA==
X-Gm-Message-State: AOJu0Yx+NUjYOpCQo9eMAtPIHo8arpuzgmlWbu18LZbZWV05p6gmUxGz
 X5xxeBdq3d6st2JBnVbdMCzHkJtgjJriIdIrETLlIVyktEsNN0AWVQa2OF/NsWF/fSxPtNauhXu
 lush5tzCk+3dyEgrZGhrbITY4FDfTeTtZjj7LboG2qCfJ4G4ZxbMtbdy/TlTPo2Hepsn23PnNUQ
 +z8Ffdf8sov4teIlDxo4W588Ce2tsbTwq4
X-Gm-Gg: AeBDiesKXATNgalIhVwPAigxxyAU9IRlqTy0NAEbeXfzCpOhDaSHrsFYbKsx1D5higf
 daLa8Xbg5gpyB+4clZUboKvsH/FMnbrzcQIlvwr3qHKlVC+m2gOkF9ltj8GuNxm/dhE2SOkbJvx
 moXqtlZjQWnNDMvnLyugzjq+EX61SCFOHQJh9SVIGezz83ceTnaPyaJapNF1/1Au0yS9Gmae1Ho
 mNguOWOW1D1z+7siA==
X-Received: by 2002:a05:7022:1a83:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-1318e8185c4mr2419626c88.29.1778083933583; 
 Wed, 06 May 2026 09:12:13 -0700 (PDT)
X-Received: by 2002:a05:7022:1a83:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-1318e8185c4mr2419593c88.29.1778083933015; Wed, 06 May 2026
 09:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 6 May 2026 11:11:56 -0500
X-Gm-Features: AVHnY4IrbrFWQhwPA-1B_YEOf5VgLa8YVCxoj7HO7SGloe_ygxayLF5VWToGdsI
Message-ID: <CAEqNhNaGEEEDC3HC-UdnTbuVN1Y8KrM4CQJfZAvH+ww-6OUT7Q@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/codebase: add link to rev.ng video series
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Os1/DS/t c=1 sm=1 tr=0 ts=69fb685e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=vnREMb7VAAAA:8 a=EUspDBNiAAAA:8
 a=YXAob65pjppqZZlLu_EA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: FJ2O5TqD1bCCqw4W69jiptXmR1QOsdMh
X-Proofpoint-ORIG-GUID: FJ2O5TqD1bCCqw4W69jiptXmR1QOsdMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1OCBTYWx0ZWRfXy8kT8yFaMdRJ
 NgSu7Vk4WLqzRY1v7tlYJ52zZQP83hmvzZLKUw4YhDJSmK3q3XVV4bJhsxt42pLTRU9e7FKrC3S
 XYD1E75It5GVe0GJXtl7kSkLwAuQmf5A428TP29ppwH7Ie/SguEeBVIlV/B3E7lR8Cbuyg75N/5
 Tzq3eTY2rR+tigwF/5UL76DIy/3ZLAxnwWZDeMlSGSjDGuCsQo31QjI9dS7aLXyWUeM8IpVOez4
 /SwTNE8tqwvH/604mYKkEAQVDbcecDnrZQd71B390UN02+7qwAAOAm2u1W2eNclKWHhBkjPqTgD
 KjPo1qRqF3eLWtv3NelROoRRVZYy4KzSHit+cqv1349CLnvfb5UIstct1yibC5QGBUqrFUrr7CL
 SWAAsHPoP+XtcowbzkgNJMp9GUwzL1wdeUKYHrdOVLvC4xFBIIT5rX8p+yuYaZUtuqRs2lCx4vu
 lOglrZLOejx/RQ3EF0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060158
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, Apr 23, 2026 at 4:36=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Those two videos provide an excellent introduction for a new QEMU
> developer, and such resources are rare.
>
> Kudos to Anton Johansson <anjo@rev.ng> for creating this.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  docs/devel/codebase.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
> index f09307b8971..f065d7eee0b 100644
> --- a/docs/devel/codebase.rst
> +++ b/docs/devel/codebase.rst
> @@ -8,6 +8,11 @@ organized.
>  Beyond giving succinct descriptions, the goal is to offer links to vario=
us
>  parts of the documentation/codebase.
>
> +Those two videos are an excellent introduction to QEMU codebase:
> +
> +- `QEMU Dev Starter guide - General overview <https://www.youtube.com/wa=
tch?v=3DOCBLTMKLGAk>`_
> +- `QEMU Dev Starter guide - System mode <https://www.youtube.com/watch?v=
=3DjrZ56K3Sl_k>`_
> +
>  Subsystems
>  ----------
>
> --
> 2.47.3
>

