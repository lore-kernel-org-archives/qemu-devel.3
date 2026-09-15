Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2895C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6a5I-0007HG-MJ; Tue, 15 Sep 2026 16:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6a5H-0007H0-D0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:48:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6a5F-00082P-ME
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:48:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItsoq277213
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PDDcox6XIolEWmMdxtVZWjE5lnF/fbOaI18229N0ODI=; b=GbiMhs3K7qTy2rt/
 eLdlPDICIXVYZAqaAtL96GgZFXvgSjjNsVNf/YSujQ40BaRsGCcDJTT38x4mUvfe
 74nX2BKZdmgBju22XBHZhVeZzA8kxz4zz0QztiELb1qyUiTAWCaGvqn7ZRmbXXq8
 wWb3HVhlcVBtgdZW66uPtA6pR/wKR/Iutnl0vAYVEoFIoBQDNMUjfQXemivJfYYz
 cHFKtcavAIAoFwD5VyK1CBup6du2cntc+AgwZRU7e2xYyKZuli31EmwG0G3+Qrl0
 tHvWYu7sxiKejYvWiJ8JlYAuWmkq1FmMCmPUsixLvBBYfCeTxNdBRFa8qI2nV5sy
 i9PGlg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2k8bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:48:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso6597052a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789505331; x=1790110131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PDDcox6XIolEWmMdxtVZWjE5lnF/fbOaI18229N0ODI=;
 b=W1N0Gi2EO6bi/lKzssS3vYsU2ynprq0LSUxI0kUvSN8d5LWqZg1UtSfu7lKLWfqytc
 p4i+AN+nu+9f8DvzxDsVEFNm66QhnXihJRIxEcgpxmvio/drvxQ0UcyZIlzxSIHkBf2G
 xTkYIKuMJB1AFE+e7IhjgT197P7p3d+Hq2KQJ1FU7o+JAFMAjJ88DoGiAwOWV6BU01+W
 EB1pAoahoC2JNUmP3dMXcxQZKY9O+K/PORy6Bhdyq8qwbTibEA4euq23KvRYqvy0iTu6
 +obk+D+tCzuh2quVVZ3SsC/Cf3+khLpsR5FHtxoZf3VjabOQSqpDf38aAQo4fjmSi1UP
 jhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789505331; x=1790110131;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDDcox6XIolEWmMdxtVZWjE5lnF/fbOaI18229N0ODI=;
 b=CHhdec42hrB0ly77fGuKV6ONdNmx17NS5/dbeQS6sNTjSVp4+fJxWkAWULk+recnMC
 Uvar1cOtA2gMog729jqoNASxsVcWt16bUC1VAZRTDLG/JfSDIhRrA+2o3hezsOQS3hyz
 A5gDLoZvjo8pq0lg9GDpQNy+nu7C2iBO1Q98cUpsF8KTZJc+pnPoyk2GqlogkJZewwMI
 Fn+tue7SUpNv9k1Bb+z0oBPY4H8dMOruKYq8d9e/xjGQdqAEFU/owqTDjaanYRPVCa1x
 gD8dFerC/w69hBoknlGInisIfyucy/rMiUZW+Jp7PuPppAX2cwwiYZcnyt2ftaEQ7oGC
 Tkxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHFz51iIJi/6l7KHaab7FMfGJFVQdl+K6UqrxyPx6/NaygyQaaCCp60uEWMqP6kVo9Erlf/MfIvpUx@nongnu.org
X-Gm-Message-State: AFuF++lQwJU6WkUWCrm0ul7w9S2FTVhbibXyu0ZR82H+B1rPbyNr9+7a
 IFyb2yIsTDCT7QHX0xvMfz8eeQ56bB+q1iY0SUk75UTcI5jOkjjO5zukVq8dmKlnyFiurV/X1Wt
 GsdyojkDAU3gYJF7ltYtyiL9M5Qa9nE/tdXfDG1HyahS+HFN0AyJ6HaDfUA==
X-Gm-Gg: AYBFou1NoNUadevcbbNjEZYEwzH67PVN5B7mFRHqz8bPaB6diRmKZNNERANNCBOCmUg
 SbEyMGL/KaMG77Qb6aJaJhOVwWdRw0Q6SuznOckRV7uF91IM69GuLTdmXcV6+8SKN1H1DYFKrz1
 mOe2cTJgRxBxuJdnnVdTF74Rw/xg5mnZeEaGx/klcguhPD6Cq0MgmUIfsTaggWlJtGbogPVpbng
 grI9rqoy0doeDdfoDqiamWK3ATuOsuleygGaelYPyykgG55+1aT85VjQuUF57pm/gZo2jNy21xF
 lus/c/9T9LZKPx4axxjIr+IB/OS+mqmLhKsjKItdxjq0iyAbeD8VTVWp44VHHeIOIjawq28Y7Ql
 S+9NbVeAt4W+mKKoKaFSLMXrenrjUwzwUJTmGQpPQoIUf3wjlu9MQ7NNOQEZLNapRani/
X-Received: by 2002:a17:90b:4d0e:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39e1e47abbbmr125115a91.12.1789505331293; 
 Tue, 15 Sep 2026 13:48:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0e:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39e1e47abbbmr125056a91.12.1789505330713; 
 Tue, 15 Sep 2026 13:48:50 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af6593sm1385342eec.25.2026.09.15.13.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 13:48:50 -0700 (PDT)
Message-ID: <3b18751b-3d78-439c-9348-b4ffa47ecc95@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] Revert "configure: remove cross_cc and gdb
 detection logic"
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
 <20260915201601.1207839-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915201601.1207839-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: krIORVcPdvT-yPwly_DSOCMinDkKhvL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMwMyBTYWx0ZWRfX5XL6H+Ve6WBI
 wT06mEwiN/UNIDSID2zWmJCuXfLttXKvfKX3dz0dXS+MK9BNe94b/OJekOb6FgAkAJFap9sg1Ku
 BRNLMrfsUtehZBmMNb2/elbh9/gBVP+idQKJ/LlD0DVMJsi9PZ9vdx1BsECkMjsj5sFG3H4miZN
 gXOhwomGzy9y6FsAHwdZQ58IWIqA0UyMK26hhnGwzuyxGw/gPIwOGvqPxYXpUACHgHBRvfxP8Wl
 c16vUKxDlXgIJHOsvIQjfDEM85KlTcUXnktAHC7SWknTmcv9dfOYVNu8JMMgMhhJBHX2cdOoMBI
 KZwBPtRaC8llovE32lF6ecgo7y/CI2GPLsDvW65P2ylI1ExusuhHvwqY9Thn9lg7WqFbofzEAJJ
 uzaF5Hpv3YpcixB/92+glQ8SfHMkvdIg/Kx9FayJ7R7W26i0SB3DGa2GUdsVjnoIOcPQ0AxOFvD
 OtCWEeiG3j2t5nZB/6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMwMyBTYWx0ZWRfX9ScTvhrqSw9d
 AtLX4ipvEhqzF13tYD2wNaQbQQWLxxXjIO4XCLdbOoJnMV1Uzl63EQ9oVBQC/zEp+4AyDuC60zC
 wftZGfkhgqgugyfHUcjaRCDVg42G3+k=
X-Proofpoint-GUID: krIORVcPdvT-yPwly_DSOCMinDkKhvL5
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa9af34 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=c6L8vRCQTaNpNBqIKPgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150303
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/15/2026 1:15 PM, Alex Bennée wrote:
> We want to restore the logic to configure as it's also used by the
> firmware builds.
> 
> This reverts commit 031f935567ab8abfa4e84682ecea08915ca9656d.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 461 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

