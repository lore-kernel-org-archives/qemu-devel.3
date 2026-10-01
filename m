Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AF5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCNnI-000824-L3; Thu, 01 Oct 2026 16:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCNnG-00081e-My
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:54:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCNnE-0003IA-9E
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:54:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fscs02686639
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 20:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7wUeYxW0omCcFiopDDahpGHg24cE9hRmoJjqWrNZ4OM=; b=m1voN/XiSwP1sMRD
 5DOlGRoRT8W/g2C0JoHnjkFcpkCwtMast2lq+i/zgu9ZtDSBPJZK/zD+GHnCD0G9
 G2XUDBPbwCntQX5QUlM9fKouNN0rgFHQhZY4w+6wzQxkjMLSl0kS0aS87CDPDTsi
 41m192McCXtVNJAaafkZXl9Bp2x6rpUi/467SZj57N6Ytx0irIpF94Q7JPLZRdKL
 NerffMr21jQo3tcnHKUPB+ILCEiKpR8gojpGX5B/EVn1iIxp0ZMG4XnJrVYieUgH
 WAvCd0uqvz4uVtZbaFhw0cafRLUANyB+JR3Y+AWrqSA/0zcpOvfUV/F9M1xzW0H5
 UvMfoQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a9caa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 20:54:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34afa104860so4619781eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790888053; x=1791492853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7wUeYxW0omCcFiopDDahpGHg24cE9hRmoJjqWrNZ4OM=;
 b=E/9pEEshmupFNdnOX6NQrjc5SXt6WtOt1gSKrBYe9JGmka0AGaRewZqGBpnq3kDuLW
 QPjt1xQi+ZqnBMkwdgYBhbHB5B/YbWPE2uGgQaYMq5igenXLYrQJ4MH35xKEX9dKfZIn
 6CkWzfCVvrlwDQye2NVF5rr6G3/6CtCQfTV7YdmVnuBmRP99ecPYY40LUSBNGS0N1WO5
 PjJwm13EUCQc3W4X2yBa7eajtTf9qeE8lVP0EySFi7olfukCeD8Fv5agf/GVGPrhzK/w
 o1UVzEkzD9UkcZRjLpFuRQsEhhfhTaeeqXTRkp1IZeBZ5M1oP+JBZ4nk0janSNU4byc1
 omlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790888053; x=1791492853;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7wUeYxW0omCcFiopDDahpGHg24cE9hRmoJjqWrNZ4OM=;
 b=qSGCHfLTRoOMPh0PERo6iZXSeIsFd5TTOOqht+w1EjtefY1WQ58wv/TNnh3HJyxO4i
 73Tusklj1X+z1WJSfRPAYdLhXcH4xPDonoTXgOormD4UzZMidR/fehfJYvwq886PVdtJ
 RtwVY9sKrJiGcZit3jw/8OfGFS9uIMMfxgKk7ICwDa4+ENHE/IHMo8eYQS9R/9ZA7W/T
 6MtyTvUw+/54O1ZPRMLZ5vBU8JicQZhMAfTe5xj8YZCxKlimb3yrNDb5EzMKk/h3S5mn
 oo8KGW3Y2BbN/+SsJwoelVgilMGW9AkcMnsLXguaEfNqRoKTxtnVGMzgUsCy2pQR2p7D
 vorQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4Jzq2gvQoDGHn8yhbiknK2uYP4pmw7kpnnCG0iA6JG7W/qsSCUbzaAXwFBl0Z6upEc2K6EnhlMuyY@nongnu.org
X-Gm-Message-State: AFuF++naMOodmmyxMwvUg5RMhEkbMNaeG67Op4j1zP8VsD44SNgOsl7R
 Pd5JBWsAfynJb7PQo7KnQcGZ35ElrETZZTL0xy/dBqm+tSm2YjCoGsAdR3OIIPIW/w6YNAWkyiR
 6i9hqTrx2mk+HOs5T34gI0qf+C2bdLkyZfLVX3GJAM72Gtjnj/b/BEnNehA==
X-Gm-Gg: AYBFou3K33BooCjAVt0ArChAEpJAqWBpiZiDpsXeJ/YR9RThXkNyaQVmsV16B/gG4VA
 +J+DZ9xLnb6Q2crfijwu7OdQuOBgXwsTLQZO/PX7Z+80/Awk3bqUsPFyZZOL3/6G0KP6+Zy6WVs
 gSIyPe8lg76mFmZ+48NeWEmNq1eK+xrkjYFP2NFMtHgqyOtbu3F22GgS9XQL5eCmi70GYzOVeSq
 VgL478LmvQzNpxzvKG/MSqcamfNHHX+qdw4krs3PKVXrrRR+7XPZExFej4Tlkm9QL3aVIg0SHZg
 c523zLEz9Fvzuo9OfCUsd+NNJpQeePJYoHgMlD3PGiSIGl33I9PnsNZWQrLpfFm9rCfH3DBp7X3
 Ud8gbAqKPEX9LRNVG0TQ1Wh3dGGNr07I06OG0oimAmXbUZYI3/si12Db/P9ReE+rCDu7ClA==
X-Received: by 2002:a05:7300:ea0e:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-34f21859675mr474315eec.29.1790888052500; 
 Thu, 01 Oct 2026 13:54:12 -0700 (PDT)
X-Received: by 2002:a05:7300:ea0e:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-34f21859675mr474290eec.29.1790888051942; 
 Thu, 01 Oct 2026 13:54:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f2dfbbsm794296eec.10.2026.10.01.13.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 13:54:11 -0700 (PDT)
Message-ID: <4ce0a49c-a7dd-4e1c-8863-30ef03809ff8@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 13:54:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace: add support for Hexagon
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4MyBTYWx0ZWRfX2HOwU6PRlHqx
 mZn3AUy7IKoU+CROLaqkgiLoagtWDcDtpl5/Stc9Ga+6EVrf6G+C/dWX13SVZx0a8ik0CMxKau6
 WZde3HNDyNAhHlogo/8X5p5JanQTdzg=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abec875 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aBqTEAnWmo68wvCxqZQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: TxdOPOZkxxRU350Rqs6-U9SMlbtfjMG-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4MyBTYWx0ZWRfX5ywyAT/dcQ9s
 CFuOwc+23RvFqVqA0iI23Xl2fjiivlPgBdi8MlYy/qGJ0vqmrOLr9q5/0EIWwcBcLijcoWtReFG
 XpPSgzGafZuhLT51W+mvR7t8RWYvRj68K7IglbTHPrYnSU/d6l1DBz4NhfE93Wlx1/BuGmRnuE+
 T2+N+nl30PQn9wGF0OpluwqEjwr3GCFAQshAwHBlvDXXDmPCaVrYxylKBG3WjHansnz3BEqy8Sw
 1+eYhMSkimwUNzEv218g25I8zlvrQvQICpZB+lQb8LXK616lWfBjQ6WrJtUt0YbxVYj/2cGD6dr
 tA3OB2Sgdcqa3jSpjKA9pmKZJZzT6J8p3O+XcoXZU6rGwIGWBPt7AtaTD/tk8A1CCY9XxS6JTIB
 nR1/eaQfCdh+l1+ODGG29E4WkQQmHZLy5mOJI8wdVHSUp0ra3958jssgdnIlVNXL75vS1/gktUg
 5OpQWH0INcbXXQ1ajhA==
X-Proofpoint-GUID: TxdOPOZkxxRU350Rqs6-U9SMlbtfjMG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010083
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

On 9/30/2026 10:55 AM, Brian Cain wrote:
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/about/emulation.rst  |   2 +-
>  contrib/plugins/uftrace.c | 130 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 1 deletion(-)
> 

Thanks for sending this one Brian.
You can take it in your next pull request.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

