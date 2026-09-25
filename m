Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA2DC9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEF4-0008U9-IU; Fri, 25 Sep 2026 18:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEF2-0008Q9-B4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:18:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEF0-0001WM-Hb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:18:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIngDo3014484
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /XlHW0xtjvGn4mXIU+I8Zi3uNKRhZ937Ff7JI1x8uiY=; b=BLYHVczfb1cpU4Fy
 NcUdC9/H7++Xds6U1MS24ZymIenrKgozUHwPTjlr4hru0zAq3QLi4+HaenaX6pcw
 jredIBkAD60SBRnZ0aCcYfVY9ER5Zjz75BKjBCYfwgnGu/FcVSkF9uiT/iuCHLZH
 oU4zV6KvhljMuK8KtjLo+BY+FS5qqil55FxocmpDGFB6dquWumjwakw2Bd96/oow
 tOXm26wHWeKhn/xGa2Wmn6w0+nbA8Xrv73EbXiukwq8BtvJv0wvn0C+cGO7Rt0Yt
 noz7e1VcgecGvrKfQ8XQ9dSrPJCGtixPw5ztBsmoke5YyMzfgU/wMft6mt7GrBY6
 dfc/nQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwufk1fd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:18:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-342b66c0b06so375293eec.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790374680; x=1790979480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XlHW0xtjvGn4mXIU+I8Zi3uNKRhZ937Ff7JI1x8uiY=;
 b=STHU+cWXtOQrrboS3TaANKtbemkCaOGfvP+ZOlEB72DbnUVTqmD8cWhLeyHOvb7xwr
 rFs/yr8tJ2Zll5+HdMVPwhAsRVrqEqtDTBovYs2GzJS7qJi4keB0fj2/WsSjBV06VfWq
 TpRMhumS72TULavujxJZb4y2lEKabjjnjKolFzquMFd6dpcP4pdaG2E7R+aaTXl4lc4+
 WA1DZWJVcNRv+sLqEEoA4Nfy33DL36NCiRLFdRAADaL0zm21Wc7exuFjbV7DsTTwepal
 z2XwM2iYzV8ArgBN2VQJzDfgOSYxo45zc0l+tHnX9k/xEkuDxsmrqv60gg0JN5fawqkJ
 eTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374680; x=1790979480;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XlHW0xtjvGn4mXIU+I8Zi3uNKRhZ937Ff7JI1x8uiY=;
 b=rPs9HR4E0P+UGuV/KhTnYCw2JDj/NFb2AG2YNa3w8yMHYWaBagKT3FCo0uNzyN8AvD
 yakUrD5P49k+edH2F8kEqgImbidJ33R9FKS57yocgDAqs9p1xnF4f6uM+qaTa4xBFBsu
 QJECK2gHTkfdolwIvq73ejAan/FAtWTdDNtUzseyA5ftkjxvrLwsyaWajq9XUXhf5ZAZ
 jWH7yW9ZhOxZebPK3m9M8J0JFQwRXksL32iy3TZTlG9PiVltiiAii4y3/Bngr59NbHYn
 47eQmi9HIKE/41/fDl+7KtINSIeFJ+jkASpEiu9HcMS6XZ9E3BqWVySr4BaoUC1XvBdt
 dDHA==
X-Gm-Message-State: AFuF++mAIXViOm/9J0oBw8yjjUWtF8B5g/cZTbJo1ybYCTYrMZ/q2PUQ
 Q/8Xov/CCEzEKZpSPkkPscMtjeEHei37WLoZXi43uOV5nkciSm+Ge3eTaB7Q9jGrJn7xlQ+ZYiR
 5napPlwHkpDashe6/ky/K/mN7f2z2YRG9MQ7gcIqeZJj0DXgd+3ewgsCxcBx6c3z8Bg==
X-Gm-Gg: AYBFou2oDGAAFJYzvAbCSG8dwEiAM9OCWZ1Tr9z7lS+1HlUrfnQ1henSQvK/gRY0CHO
 hUbzsrtSZxWocuRjr9IZJtC3k8AyaZncqwQCV0/MiZRlE7Czd2qTHooDy+1Io7y9PKgsbkdonsO
 RN33j3EU9eBZTb2TEmH1seWdqLMzfg8AKj6qxrAKd3qsPtrZZUtpGiPpRY6yP7Jyi/VkxvbKzEZ
 oI/3MQkFFl/lOdZF2Ce5dKkydfaVFyKQNB78zU8TkcdgUOtV9yGAAa2PFbyrwxMzjP+qxwSP4sJ
 gbDHYZKUg7chvL8XMOh3AdmLRoxniqOf0WljP5wwThgWuJE+Qgh3Mu21JCsvgdVp4jwcV6sIcd1
 jJBD6VqMnD7I39jwXkLBpxv7532MnHNmnQ119MZEl+xpFrMlrffLHrcWwiQ0MvT5VxKwAic4HiQ
 XPfA==
X-Received: by 2002:a05:7300:880d:b0:341:6bbe:b9d6 with SMTP id
 5a478bee46e88-342700c06d7mr1387447eec.1.1790374679798; 
 Fri, 25 Sep 2026 15:17:59 -0700 (PDT)
X-Received: by 2002:a05:7300:880d:b0:341:6bbe:b9d6 with SMTP id
 5a478bee46e88-342700c06d7mr1387431eec.1.1790374679175; 
 Fri, 25 Sep 2026 15:17:59 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145c17074sm7714597eec.26.2026.09.25.15.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:17:58 -0700 (PDT)
Message-ID: <687e19f4-8ea4-4b4d-b4d0-e01d43bf8085@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker/dockerfiles/debian-loongarch-cross: update
 toolchain
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Xianglai Li <lixianglai@loongson.cn>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0PfUM0f4ZsaBU-GevctD0VIr1xed51i_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX36kxdHDlUlbg
 5gUois6oCgAaJo0TF+bNuTqFK5Et05p5xSy1v+BYc2gwO8Bc+FH5Wy+p1mL+NVScu+m5lKE9xPo
 WhxWXswMQPlN0NHSKyPgWzzyUpKVKko=
X-Proofpoint-ORIG-GUID: 0PfUM0f4ZsaBU-GevctD0VIr1xed51i_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfXxBBmHa2fdBCa
 Eps3QxHsL2zqdgVsmFHwHR1PvQZvmvBaXvxlZ+rIachHdI6JLlhCcFdGppVr2UQgWfzMEIZJBUt
 sBF7TzRT3SdMvoXPU5/y2rvA9u8yJ7Ur+wp/ZXqqkYi2IqJEx++K3AEloRd21meYYdtiiUD52Wd
 oQP16qrCTLDecs2snSKLfptFUy7GmQFhKQ40yoQG5qAuY55hESyxZ9IKTtVIle9cXVfw4WZrun/
 QsoR+ToOQ+UV7QX59Um7wHiEpM1o/Lly7TaXg7B8cDoTXSiM54YUQLU77Czgy1VylrlyOOCRP4I
 p4WSCVU0eMtyK19u7qZWMDpCRfxVkWYsss//U6vPVW5x+FwHlGYX4dhYugQsRTXU2LeKVjzv7zh
 AqKC/hBTURt0Nk7LXneT+/WyHzkHzOGzPPfX/iPrv9pWnbca4v6TiGakUnh9/0bNW1I79w6LKfQ
 jiCUt5Eyt8HRWnMk19Q==
X-Authority-Analysis: v=2.4 cv=B+wsQ+tM c=1 sm=1 tr=0 ts=6ab6f318 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DTbva5pb6JUnWUDYprEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250088
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

On 9/22/2026 5:05 PM, Pierrick Bouvier wrote:
> The previous toolchain was embedding full libc when doing static linking
> for tcg-tests. As a result, each binary was 4MB is size.
> With updated toolchain, only needed functions are linked, thus reducing
> binary size.
> 
> As a result, we save ~140MB of disk space for tcg-tests.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

This was merged into master (efa3b9d5ac8024078225e1ab434411fdfe53b457).

Regards,
Pierrick

