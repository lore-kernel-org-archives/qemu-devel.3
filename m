Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75A4C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3eJ-0002Fq-OJ; Mon, 17 Aug 2026 16:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1ww3eI-0002F1-SW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:09:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1ww3eH-0000qb-5V
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:09:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HISJ7X2706787
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 20:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=h/3n4irW4x4
 M5wmUN44ve9E4WFeo5naHBP6zeSTiKhk=; b=okG3piZNvgp30GeokRKupIHb4Vy
 HnAmRxyfT4J/i0JBXvi/9GThwQRypfcUTwRg1zfNXV4R1hlA/sVyIIqDTOBh08Zp
 o8oLrXVMmmbboo6AnMu/oU3NNScA3H53VFQ0bmKD/vR4gIKiV2nkMIvF9m85Fi6b
 etv/Uj/T/TsHRg7LX25iJwiS19jqBFrol6dKS0NxGQXXMEs3EDxTe2LCy4KQWcac
 8r0ZdQt5JGrssxpkcS1Y6Yy8WUq3/l0ot9zoVQ+Qy4C+I6kI2lT5L/x1BI828J2Q
 8wCA9SG2e/k64OLIVOHfVmH8cnkL/AIF/78w2ei76i3VCCIU2v8wGMUCmIw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1jwr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 20:09:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so5823297a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786997369; x=1787602169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/3n4irW4x4M5wmUN44ve9E4WFeo5naHBP6zeSTiKhk=;
 b=HjfruLWub6yTTtW+1xiS5JLsJe2W0pcpidnPkEbjMZoih51Gtzqk9MRdWpl0e2nfFZ
 Vg3xytxyYc/aMBCmzOIIkO+c8/UJyzvM9y/nO9KpxP7geTbiL8BIHjU1SUPp7FmvEZRE
 IaGXsDRt21PveNsfwfTAUcDEYJkVsODekglbc4EKSLAc0sam/rq0APIbBuYZcHnIGSjJ
 BVCNXwHu5DbsXcXTZMpU0mJYS+d9bQTG9U/XU4hJ/cHZ2h6eHPgxPaCRZcZpDygW3AN5
 +Qi3xll/kVgRTN/89psKcWTYPTCGbTNR9cY/7oDXkEOlWweGnIFfvHBrsoFu/+u9bIej
 HWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786997369; x=1787602169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/3n4irW4x4M5wmUN44ve9E4WFeo5naHBP6zeSTiKhk=;
 b=LYrKAASkhQTgfPiY7LpI/aTRo5jWK64Ax6ye13M31LG/kK3odrrN6j747uNKGGaYWh
 +Db1ecxENo5RXBxqOL4mi10X/zx9dLV7ZYDVB6RVBHVvsaz+WBxzEymbakreL14bDqmX
 RTUfvVfWiLsbVjFmxS5vf5wi0OX7Xav+ePPd0tniW6AdzAnZs1UfhnhXelIWlQCg55yY
 Xqjl5abV5agnS31/H8aOsNUaeXw7x2Q4hQua0G6gnYnyehKZIVUubMIfBV2GDx392Tmb
 b87qLEjFdj0hbOcyGsT9vSqDELMYycqyCsjw9yUjC8ild/Co3plNV3zAyBQn4AQwxRG8
 L3bQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaN9z8RN13mwRVwimaOPbFFUvsUbsiT0K2JUrwEcXaE3t6AAapm1xL41ZPq9LeXhoI8cMHHA8/bU7o@nongnu.org
X-Gm-Message-State: AOJu0Yz+urKpyW99pRwD6GhSnl6kM/hLhBZqSBMn5vNpe9s3pOf6h8dL
 zI+hu+9Q6oMSft3a3FVcwplcONJMJJjsCow8V3zkcWtJea6bX090iblnOwFVek8U4ksqTXg3qfg
 PzaDQLSMK44uonhz+B0K6eTvFBjrcTAQSdQvXwG+3xAVj/z1TtIzn51O8WQ==
X-Gm-Gg: AR+sD10C422ZZ60VmOt/AAtir5kBV6mR/mWgavwm/o4cf1mhGcKrng8u6bBkn4CMMHH
 W9TWaKP6XVivzHIheTlwkougS1gm/tGEYD6Y/YAHVF1/ru33Qm6Lowm1fK6NBQmuqJyplzQzVyE
 rq9NI8pfoRAb3scRxL8L2F/JXERN07OB+o7Y0BSI7oGLhICl5QRx06AzbEHvtzXvFETOlzTUld0
 HU3XZyNujxUlYT0+VV+yXCoo/58/S31Ru02h8FMPThK7j/LGkLnQfOYpA4O/0k2HVntu5wH//Z7
 gFH0SyS2nbRKzoFmuZYOCHo6JHkgaPVzDDgh5ei7hdYjwJk7uc5IklI58hOZYSH6wD08nTYxCxg
 slyUqhlQXYqQekJdNERR4b1fI7hiCiSLbODiZ1be3T0RGxGawK/NGl9KdMEb1DzQ=
X-Received: by 2002:a05:6a20:2591:b0:3c4:1916:9d3c with SMTP id
 adf61e73a8af0-3ccda9f72dbmr2876690637.15.1786997368759; 
 Mon, 17 Aug 2026 13:09:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:2591:b0:3c4:1916:9d3c with SMTP id
 adf61e73a8af0-3ccda9f72dbmr2876587637.15.1786997368025; 
 Mon, 17 Aug 2026 13:09:28 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141530442c1sm8200396c88.2.2026.08.17.13.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:09:27 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: philmd@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
Subject: Re: [PATCH v3 11/13] target/hexagon: Add an errno mapping
Date: Mon, 17 Aug 2026 13:09:25 -0700
Message-Id: <20260817200925.3280245-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <27fdd807-549b-41ba-9a6b-64ddf4b8b0ce@oss.qualcomm.com>
References: <27fdd807-549b-41ba-9a6b-64ddf4b8b0ce@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a836a79 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lN6XFGsavNC-WikVixsA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: mkIH6jd5Nu7OJTC3U0ey19F_TSPFqJqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1NCBTYWx0ZWRfX4YjF3/X9NJq7
 qfYg9QTtPRcEu1010BC3WA1Y4DaxSs5PpK2PvOonjXfYFCAZkUoeli7SyszrC+yg7V6kVsezzMb
 34LH5KDrPtCVr6HUb4s6Jhcwwq5OBoKhtj22tBmlMfSY6+udzYlrIywFvMh3V6jh+tBCHeLgMUa
 ZtSuIWB8XBSp1T3xW91VRO/8lhIZjOv3hEVsT/6Qfh6HBylRWO37yTeoMUARy1knmm8s/tFIknZ
 iSoNxlGoVsCkyHdOXP8bJtwqjmSZYETMel45MGb8qkva6jvKyo9xYLOF1OwGh9j3NU7R3LqqcIU
 UMRRJxqKLvu3u4Nm6sr1BA6knDpdJb1rZNPUC1g1JcaEtsqy49IGoD52KaGMnT8iSFv5Ke76sSr
 +G1J5EvwgGCSmuma06dJSC4gWdlWfF1seaT86NBKuj3REqWlRvfR1IHfxOHzkFUb2+tnIMnbRkN
 ry4poFctKotZNa0q5eA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1NCBTYWx0ZWRfXxvrZ5kqoIET3
 hr7sg09E36dFiqJyoTJ/EKSoCOUYdmnqvsOObB3Y3OHBJjEHNJsLgLzY9EuvLKPIwIG0XRxhmas
 KIM4K3t0l7ldEF0WCQEdIcFUzxYaMUU=
X-Proofpoint-ORIG-GUID: mkIH6jd5Nu7OJTC3U0ey19F_TSPFqJqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170154
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Mon, 17 Aug 2026 06:41:28 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com> wrote:
>
> On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> > From: Brian Cain <brian.cain@oss.qualcomm.com>
> > 
> > The Hexagon semihosting ABI defines its own errno values
> > which may differ from the host's.  Translate host errno to
> > the Hexagon-specific values before returning results to the
> > guest so that baremetal programs see the expected error codes.
> > 
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> > ---
> >   target/hexagon/hexswi.c | 75 ++++++++++++++++++++++++++++++++++-------
> >   1 file changed, 63 insertions(+), 12 deletions(-)
> > 
> > diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> > index 564a11e557a..d93789e39c7 100644
> > --- a/target/hexagon/hexswi.c
> > +++ b/target/hexagon/hexswi.c
> > @@ -154,12 +154,63 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
> >       hexagon_peek_memory_range(env, addr, count, retaddr);
> >   }
> >   
> > +/* Hexagon semihosting errno values */
> > +#define HEX_EINVAL          22
> > +#define HEX_ERRNOS \
> > +    HEX_ERRNO(EPERM,        1) \
> > +    HEX_ERRNO(ENOENT,       2) \
> > +    HEX_ERRNO(EINTR,        4) \
> > +    HEX_ERRNO(EIO,          5) \
> > +    HEX_ERRNO(ENXIO,        6) \
> > +    HEX_ERRNO(EBADF,        9) \
> > +    HEX_ERRNO(EAGAIN,       11) \
> > +    HEX_ERRNO(ENOMEM,       12) \
> > +    HEX_ERRNO(EACCES,       13) \
> > +    HEX_ERRNO(EFAULT,       14) \
> > +    HEX_ERRNO(EBUSY,        16) \
> > +    HEX_ERRNO(EEXIST,       17) \
> > +    HEX_ERRNO(EXDEV,        18) \
> > +    HEX_ERRNO(ENODEV,       19) \
> > +    HEX_ERRNO(ENOTDIR,      20) \
> > +    HEX_ERRNO(EISDIR,       21) \
> > +    HEX_ERRNO(EINVAL,       HEX_EINVAL) \
> > +    HEX_ERRNO(ENFILE,       23) \
> > +    HEX_ERRNO(EMFILE,       24) \
> > +    HEX_ERRNO(ENOTTY,       25) \
> > +    HEX_ERRNO(ETXTBSY,      26) \
> > +    HEX_ERRNO(EFBIG,        27) \
> > +    HEX_ERRNO(ENOSPC,       28) \
> > +    HEX_ERRNO(ESPIPE,       29) \
> > +    HEX_ERRNO(EROFS,        30) \
> > +    HEX_ERRNO(EMLINK,       31) \
> > +    HEX_ERRNO(EPIPE,        32) \
> > +    HEX_ERRNO(ERANGE,       34) \
> > +    HEX_ERRNO(ENAMETOOLONG, 36) \
> > +    HEX_ERRNO(ENOSYS,       38) \
> > +    HEX_ERRNO(ELOOP,        40) \
> > +    HEX_ERRNO(EOVERFLOW,    75)
> > +
> > +/* Map host errno to hexagon semihosting errno */
> > +static void semi_cb(CPUState *cs, uint64_t ret, int err)
> > +{
> > +#define HEX_ERRNO(NAME, CODE) case NAME: err = CODE; break;
> > +    switch (err) {
> > +    case 0:
> > +        break;
> > +    HEX_ERRNOS
> 
> IMHO defining the target-specific semihosting values as TARGET_foo
> like done in target/xtensa/xtensa-semi.c is more readable long-term.

The idea behind the HEX_ERRNOS macro here was to avoid too much repetition.
But I agree, if it turns it less readable long term, let's go with the
enum + switch/case.

> > +    default:
> > +        err = HEX_EINVAL;
> > +        break;
> > +    }
> > +    common_semi_cb(cs, ret, err);
> > +}
> 
> 

