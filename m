Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D23606A335
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HkxnxafF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cc7Hj+1y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXzW-0006gJ-JU; Mon, 23 Nov 2026 12:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xVXzU-0006fx-G8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:38:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xVXzT-0001eI-55
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:38:08 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGx9o2377202
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rMPYsSn6mbBKCdRrhc4/io7k
 uJ02ioIlmXJsSi6DwQ4=; b=HkxnxafFUZcFzAGkGlPLW028Lw98riYedYa1hHOb
 rHtw/wz6JAxiLLts1TzU9YKLwMF3f4ki3mgq6KJiSef7fWv9RnABNVUPMc+HGriF
 3OmrL4LZslAVS1ddvEzDNJZLmFelNTHlrqoCAXIMCmaMo+r9SmFDAe1Qc95vmwTa
 KhHNZkQ6qOg09Dv37RtnFVcPn2/Zfsl0kNW1ZWcPn4Fi1Eu1snbHTNyKzX1Ho0nZ
 Wr7Wq1BTggphTCepRXU8umws76IMH7tPPJHfyCCcQiNA0JsbCMGQYgGbCDTIT5ih
 9toThYqcKfyL74rwG2NsEIvr9iXHF6LEXbVfb4KK4s2WHg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7usjpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:38:03 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b26d8d2498so4028443b6e.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:38:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795455483; cv=none;
 d=google.com; s=arc-20260327;
 b=Hp10UWqIHp1cfufgvN4QWf1oU731ypSV4p9ii4qdkhEAP4VLSqoSdvYH+qhVWbeByl
 /O5V1mxt/aQMuiOmb3GeOOe2lyuWF1vlfy3ScEZlqSXd+SzZyC4/q+HlxsnpcIPzTiwM
 6jphhDvRN+cEGObLvpnA3aafsfwTcn0iYW42bYuAuNm6nWzXGein0fKdnC1V4o+/B+m6
 b7HnYQKwLSjWX14AVnYCxa9i91J9sz6RdIW4VXEwuHL9TWny5/n5+7EMPE+CErOGMxNX
 +yNdnHcCz1TZB4dqQMBWaxDahqffbx+MkdLyTVQ3j7tqFgdiJC0ZiXNI5KLH3cYJzgCF
 w38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rMPYsSn6mbBKCdRrhc4/io7kuJ02ioIlmXJsSi6DwQ4=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=YHpEHQvTIMWyMG72yuWJeoYZ3AxAA0PdcZE26MZUyZ08JuS2O+3QT+c2iHrwK6UbsJ
 u0JaQ+h2OPjDJBg411alkvkRlMqazGOUWMPu93gRxYGl/8Z1wa2hRyvwv7dDPc0yjeF7
 V5htAlhb3VSKg/B3w+zgBTUUthvMkPw2syMgh7O9KsrSdc9DwWfDQxj6ElptH3f28Ixl
 6vMeDCM2THKAtqkGtt/aPVL0lJDNp5Jo8hZbCWrofBVUb+0W6yr+pcd8bF9ZFkR6Pktm
 F8K3CgrFM/bMJRYmWyoOp+RPq529O15zvLVWGEIantSj3mnTUnKLD3Z9Po+sP5tA2Z9Y
 ZRCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795455483; x=1796060283; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rMPYsSn6mbBKCdRrhc4/io7kuJ02ioIlmXJsSi6DwQ4=;
 b=Cc7Hj+1ybqDbZ+BWEDEBcUw1gb5LGY7JjD6YzSPNMCjcwKRzH1EOorEpSGjI/t2sUp
 QurUtyN0hdx1kcc0Bh2uSMP2VwzZ/r/eh+qp/tQuC6/kRAgjmiCyRASnM3zOqbemwVJl
 YWMjZEpC9g7kvL5G/rkx6gSiNzT2yKX8LOuxQpmkvyJudQ7iOPKszU7VK1a2hlv+ZzEM
 i9118p5U9e3qmHEDv/QsIceSPNOwmcNkUrcpEkFU/4Tb7+4PHfDwf3UU8uIWP5T7eKtA
 8Kq0oDcpO5Bb0b3n6NBi2XXnh3cqh4g3n3lGLmyVvvwoMCDuwqOKKtxvg4ahKnfjvh4A
 br0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455483; x=1796060283;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rMPYsSn6mbBKCdRrhc4/io7kuJ02ioIlmXJsSi6DwQ4=;
 b=uz8kLOpvuFoYXEoMzZCfPzQvMMBHEVebDQenElpU2Pn7BHWW2MjY2KFwnaduSFXsw9
 UBdMab43I7sAYWyxki/HcNu5+FOBdD0VnkKdKQsr1olH6nYhkZ++YnKLNoWQ02oEFbjy
 TBX4NMZieRqMrC2hcWlupJf6b/ThFJhIoPwpkMscXEPJOxHzRhRUZ+v3VRmPsKCFk6c/
 rFOHdcVa6VZy5NHagP0uypNwoRsFnd8ACZ1zqh4BJ3YBCzvZGUC8pKyoCl+Zempw+cDw
 MpaqPwugH7l5o3//nhoifl88F8PLelhWGnSbaqF9tGfI+ew4MdgkvVYML0BCeSy6qOBW
 AHQw==
X-Gm-Message-State: APuU4Z8zYsE8enDwCXDhBa6IBIShZ5ckOi1HNq/9WalrDUt/dhTCE5B6
 77cqp7lzOduuc4Mu/EiTyx0zgMtCdpeenJApua+XLmDiFCb3jWeM4Zu3j2zilqMeXV6oE1XvjM9
 Zmu2mVm/WcN4rvgM3tMSMeo5gvzkW12dtIWzObcmctxTjYjFDo4YZT5Eu9lm5gnkkm6GWvMcWqd
 grBv/HFQG9N5kUYpusV/NEzRLNJ8Vvpfye
X-Gm-Gg: AZFdTZcxiqSxkVOui2s+cG+kW/xE0fqVlH/a8hzWrE139S+yIMbCZhz1YDMrI2HCYgb
 fDgoM7XlVDNfI8BoZfd9r/t1NPKjsgaqN4mdVgcuMenxi0Z7CGKEkXANd8jnv0R7ABU7jqH583B
 SU4tx8e/22HRiZBOz/W6zmYc53Rs1Aj03/a7kibonNMNYqK0avTF5vJukAMpCGYZW4coKyS+Yql
 vbO7PkS+2RqTFpHmQ==
X-Received: by 2002:a05:6808:1712:b0:579:f58e:bf8d with SMTP id
 5614622812f47-57a0a20af6amr12936967b6e.20.1795455482894; 
 Mon, 23 Nov 2026 09:38:02 -0800 (PST)
X-Received: by 2002:a05:6808:1712:b0:579:f58e:bf8d with SMTP id
 5614622812f47-57a0a20af6amr12936943b6e.20.1795455482511; Mon, 23 Nov 2026
 09:38:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-10-marco.liebel@oss.qualcomm.com>
 <a3f0c1bc-58da-45c5-91a0-9cd4b7e3ac8d@oss.qualcomm.com>
In-Reply-To: <a3f0c1bc-58da-45c5-91a0-9cd4b7e3ac8d@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:37:51 -0600
X-Gm-Features: Aa3M54pTtw6ByoCx_KCdwQHllPCNbSGOH7vTtYMYnvUD_qPiG7H2d-JvaCuDbhw
Message-ID: <CAJ+KCYOATScXGaY=71V7cCJUA0FrDPVe64zQjNN8BXHK6K9s6w@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] target/hexagon: retain both scalar packet fault
 addresses
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: m4XKb5nnIfEgeXza-51J5oiq0J7WxdbY
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b0479fb cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=3iO83jFRTvMUoz19oAMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: m4XKb5nnIfEgeXza-51J5oiq0J7WxdbY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX4h6n16ppsf0z
 EkOqh6k+XC+aYjR2PFuBc4QpIMgi2F/w7t/1v/5N2IUwLgj00S8Hjv4z0DDspA68OcJigkJFBk8
 0NNR6syr+H9m53rx69l5/nY76XrtMVg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX3MpeoaLT94VU
 t47pJUJLXt/ggsNBFgmXzMc4/mHRfj9VpH9TS61EhusbK660LQmyclMNp+3cE/MzNayX5B3KjAj
 gUl+JADJ/cDOZ1VejAM46wsaDBR9jDhZziZIJ2/FFHZJTokTRsWOoC9bw810Vc7yN4gb3Lff2JI
 OYe/mumx+mV8wUeUrX+nmxCu+SwYWD4WwcQsNpcgGbYAf0KvKE3jB7qFyCk0ROBElMY3yu9LZvi
 WfgITlMkAbZQq/318nmez6z0FHJQx6TDzZu9pZrds7FeiiSfjCy/akqETCy5L3kOpeQIU8Ngp6N
 UtU3+zVCdxOOUaqnhGP3OP5eLKPs/u7GCcsv+WHWx2CrMXEl93EbXahEi+krLhedOvcKhwtQkj7
 46D8Av73JuuJpjjAG8PZr3sICcWlOJ2jM8vOmOaxR6qFYu2G6GxVDFSOWjImVoHECH9U9TnNvMx
 cgm8ZOx5PMqTiJS8zHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > +#ifndef CONFIG_USER_ONLY
> > +void gen_log_mem_address(DisasContext *ctx, TCGv va)
> > +{
> > +    unsigned slot = ctx->insn->slot;
> > +    TCGv valid = tcg_temp_new();
> > +
> > +    tcg_debug_assert(slot < 2);
> > +    tcg_gen_st_i32(va, tcg_env,
> > +                   offsetof(CPUHexagonState, mem_access_va[slot]));
>
> Can this be isolated to A_CONDEXEC instructions?
>

Address recording can't be restricted to A_CONDEXEC. BADVA0/BADVA1
must report both active memory-slot addresses, including unconditional
accesses.

